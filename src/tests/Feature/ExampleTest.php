<?php

it('returns a successful response', function () {
    $response = $this->get('/');

    $response->assertStatus(200);
});


it('has welcome page')->get('/')->assertStatus(200);