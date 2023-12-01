using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BancoAPI.Models;

public partial class Client
{
    public int Id { get; set; }

    public string Name { get; set; }

    public string PhoneNumber { get; set; }

    public string Email { get; set; }

    public DateTime RegDate { get; set; }

    [JsonIgnore]
    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();
}
