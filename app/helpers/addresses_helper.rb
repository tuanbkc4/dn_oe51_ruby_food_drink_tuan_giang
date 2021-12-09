module AddressesHelper
  def set_add_default param
    return true if param != "1" || !find_address_default
    return find_address_default.update(is_default: 0) if find_address_default
  end

  def find_address_default
    current_user.addresses.find_by(is_default: 1)
  end
end
