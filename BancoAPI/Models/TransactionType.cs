using System;
using System.Collections.Generic;

namespace BancoAPI.Models;

public partial class TransactionType
{
    public int Id { get; set; }

    public string Name { get; set; }

    public DateTime RegDate { get; set; }

    public virtual ICollection<BankTransaction> BankTransactions { get; set; } = new List<BankTransaction>();
}
