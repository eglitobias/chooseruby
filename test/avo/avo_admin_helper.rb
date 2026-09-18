# frozen_string_literal: true

# Shared helper for integration tests that drive the Avo admin panel.
#
# Avo resources are DSL class bodies: their `fields` blocks, `visible:` lambdas
# and computed-field blocks only run while a page is being rendered, so these
# tests sign in as an admin and request the real Avo controller actions.
module AvoAdminHelper
  def sign_in_as_admin
    post "/session", params: { email_address: users(:admin).email_address, password: "password" }
    assert_redirected_to "/avo/"
  end

  # Requests an Avo page and fails loudly with the response body when it is not
  # a successful render, so a broken resource is diagnosable from the failure.
  def get_avo(path)
    get path
    assert_response :success, "GET #{path} responded #{response.status}\n#{response.body.first(1500)}"
    response.body
  end
end
