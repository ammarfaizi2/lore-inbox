Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSKWVzY>; Sat, 23 Nov 2002 16:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSKWVzY>; Sat, 23 Nov 2002 16:55:24 -0500
Received: from imail.ricis.com ([64.244.234.16]:34565 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S267085AbSKWVzW>;
	Sat, 23 Nov 2002 16:55:22 -0500
Date: Sat, 23 Nov 2002 16:02:32 -0600
From: Lee Leahu <lee@ricis.com>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 hanging at boot
Message-Id: <20021123160232.49473a4a.lee@ricis.com>
In-Reply-To: <1038048137.17592.3.camel@garaged.fis.unam.mx>
References: <20021123113215.V20474-200000@freebsd.rf0.com>
	<20021123142916.GA18127@bittwiddlers.com>
	<1038048137.17592.3.camel@garaged.fis.unam.mx>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.....

I have console over serial port enabled.
configed console via lilo as console=ttyS1,57600

i am able to see my kernel come up, but w/ module probs as others mentioned - no depmod :( :(

my system is this:
	2 pentium 3 1.13 GHz processors
	1.5 GB sdram pc-133 ram
	tyan tiger 230t (s2507t)
	VIA Apollo Pro133T chipset
	VT82C694T & VT82C686B


Max Valdez <maxvaldez@yahoo.com> scribbled something about Re: 2.5.49 hanging at boot:

> Me too  :-(
> 
> Attached config
> 
> Max
> p.d. sorry Matthew !! i forgot to change the address !! sorry for the
> spam
> 
> -- 
> uname -a: Linux garaged.fis.unam.mx 2.4.20-rc2-ac3 #2 SMP Thu Nov 21
> 17:15:31 UTC 2002 i686 unknown unknown GNU/Linux
> -----BEGIN GEEK CODE BLOCK-----
> GS/
> d-s:a-C++ILIHA+++P-L++E--W++N+K-w++++O-M--V--PS+PEY+PGP-tXRtv++b+DI--D+Ge++h---r+++z+++
> -----END GEEK CODE BLOCK-----
> gpg-key: http://garaged.homeip.net/gpg-key.txt
> 


-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
