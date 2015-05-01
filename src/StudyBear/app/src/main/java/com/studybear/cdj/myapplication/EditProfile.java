package com.studybear.cdj.myapplication;

import android.content.DialogInterface;
import android.content.Intent;
import android.nfc.Tag;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.android.volley.Response.*;


public class EditProfile extends ActionBarActivity {
    private NetworkController networkRequest;
    public NavigationBarController navigationBar;
    private String username;
    private String university;
    private EditText fnameView;
    private EditText lnameView;
    private EditText emailView;
    private Spinner spinnerView;
    public static JSONArray classList;
    private static final String TAG = "EditProfile";
    private ArrayList<String> universityList;
    private ArrayAdapter<String> universityAdapter;
    private String classes;
    private ArrayAdapter<String> universityListAdapater;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_profile);
        networkRequest = NetworkController.getInstance(getApplicationContext());
        Intent getUserInfo = getIntent();
        username = getUserInfo.getStringExtra("username");
        navigationBar = new NavigationBarController(this, username);


        String url = getResources().getString(R.string.server_address) + "?rtype=editAccount&username=" + username;
        JsonObjectRequest profileAttr = new JsonObjectRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject json) {

                fnameView = (EditText) findViewById(R.id.firstname);
                lnameView = (EditText) findViewById(R.id.lastname);
                emailView = (EditText) findViewById(R.id.email);

                try
                {
                    fnameView.setText(json.getString("firstName"));
                    lnameView.setText(json.getString("lastName"));
                    emailView.setText(json.getString("email"));

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Toast.makeText(getApplicationContext(),volleyError.toString(),Toast.LENGTH_LONG).show();
            }
        });
        networkRequest.addToRequestQueue(profileAttr);

        universityList = new ArrayList<>();

        String url2 = getResources().getString(R.string.server_address) + "?rtype=getUniversity&username=" + username;
        JsonObjectRequest universityListRequest = new JsonObjectRequest(Request.Method.GET, url2, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject json) {
                try {
                    Log.d("RESPONSE", json.toString());
                    Spinner universitySpinner = (Spinner) findViewById(R.id.spinner4);
                    JSONArray jsonArray = json.getJSONArray("List");
                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject jsonObject = jsonArray.getJSONObject(i);
                        universityList.add(jsonObject.getString("universityName"));
                    }
                    universityAdapter = new ArrayAdapter<>(getApplicationContext(), android.R.layout.simple_list_item_1, universityList);
                    universitySpinner.setAdapter(universityAdapter);

                } catch (JSONException e){
                    e.printStackTrace();
                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError volleyError) {
                Toast.makeText(getApplicationContext(), volleyError.toString(), Toast.LENGTH_LONG).show();
            }
        });
        networkRequest.addToRequestQueue(universityListRequest);

    }

    public void Submit(View v){
        Spinner universitySpinner = (Spinner) findViewById(R.id.spinner);
        university = universityListAdapater.getItem(universitySpinner.getSelectedItemPosition());

        String url = getResources().getString(R.string.server_address) + "?rtype=editProfile";
        StringRequest postRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String s) {
                if(s.trim().equals("success"))
                Toast.makeText(getBaseContext(), "Profile Updated.", Toast.LENGTH_LONG).show();
                else
                    Toast.makeText(getBaseContext(), s, Toast.LENGTH_LONG).show();
                Log.d(TAG, s);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(getBaseContext(),"Server Error"+error.toString(),Toast.LENGTH_LONG).show();
            }
        }){
            @Override
            protected Map<String, String> getParams(){
                Map<String, String> params = new HashMap<>();
                params.put("fname", fnameView.getText().toString().trim());
                params.put("lname", lnameView.getText().toString().trim());
                params.put("university", university);
                params.put("uname", username);

                return params;
            }
        };
        networkRequest.addToRequestQueue(postRequest);
    }

    public void Back(View v){
        Intent intent = new Intent(this, ProfileActivity.class);
        intent.putExtra("username", username);
        startActivity(intent);
        finish();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_edit_profile, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        switch (item.getItemId()) {
            // action with ID action_refresh was selected
            case R.id.action_settings:
                Toast.makeText(this, "Settings selected", Toast.LENGTH_SHORT)
                        .show();
                break;
            // action with ID action_settings was selected
            case R.id.action_logout:
                Intent intent = new Intent(this, LoginActivity.class);
                startActivity(intent);
                finish();
                break;
        }
        return true;
    }

    @Override
    public void onBackPressed(){
    }

}
