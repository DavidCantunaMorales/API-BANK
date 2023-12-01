using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BancoAPI.Models;

public partial class AccountType
{
    public int Id { get; set; }

    public string Name { get; set; }

    public DateTime RegDate { get; set; }

    [JsonIgnore]
    public virtual ICollection<Account> Accounts { get; set; } = new List<Account>();
}
