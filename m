Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAIQ4s>; Tue, 9 Jan 2001 11:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAIQ4i>; Tue, 9 Jan 2001 11:56:38 -0500
Received: from Cantor.suse.de ([194.112.123.193]:1285 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129759AbRAIQ4Z>;
	Tue, 9 Jan 2001 11:56:25 -0500
Date: Tue, 9 Jan 2001 17:56:20 +0100
From: Andi Kleen <ak@suse.de>
To: Kambo Lohan <kambo77@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [eepro100] Ok, I'm fed up now
Message-ID: <20010109175620.A5913@gruyere.muc.suse.de>
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>; from kambo77@hotmail.com on Tue, Jan 09, 2001 at 11:45:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You could try the Intel driver (e100.c), which is downloadable from their website.
It apparently has some silicon bug workarounds that Donald's driver hasn't. 

Another popular cause of strange lockups are PCI bios problems (interrupt conflicts
etc. -- exchanging slots may help) 

Also please note that such a subject line is not a good motivation to help
you for free.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
