Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132173AbRAVQ7v>; Mon, 22 Jan 2001 11:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132379AbRAVQ7m>; Mon, 22 Jan 2001 11:59:42 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:59593 "HELO
	localdomain") by vger.kernel.org with SMTP id <S132173AbRAVQ72>;
	Mon, 22 Jan 2001 11:59:28 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Mon, 22 Jan 2001 08:58:50 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: "Hubertus Franke" <frankeh@us.ibm.com>, lse-tech@lists.sourceforge.net
In-Reply-To: <OF705E9D76.E5523D4C-ON852569DC.004A374D@pok.ibm.com>
In-Reply-To: <OF705E9D76.E5523D4C-ON852569DC.004A374D@pok.ibm.com>
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
MIME-Version: 1.0
Message-Id: <01012208585000.17926@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 January 2001 08:57, Hubertus Franke wrote:
> Per popular demand. Here are a few numbers for small thread counts
> running the sched_yield_test benchmark on a 2-way SMP with the following
> characteristics.
>
> model name      : Pentium III (Katmai)
> stepping        : 3
> cpu MHz         : 551.266
> cache size      : 512 KB
>
> I compare 2.4.1-pre8  kernels (vanilla, table/prio scheduler and
> multiqueue).

What's 'table/prio scheduler' ?



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
