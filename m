Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129770AbQLTSXJ>; Wed, 20 Dec 2000 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbQLTSW7>; Wed, 20 Dec 2000 13:22:59 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:56634 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129465AbQLTSWy>; Wed, 20 Dec 2000 13:22:54 -0500
Message-ID: <3A40F1DB.84D53F7F@holly-springs.nc.us>
Date: Wed, 20 Dec 2000 12:52:27 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us> <Pine.LNX.4.31.0012200848430.180-100000@dlang.diginsite.com> <20001220121351.D10408@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" wrote:

>         You can use spf to add some stateful inspection for PORT mode
> ftp.  Personally, I like the masquerading option better, though.

Can you give an example of using MASQ selectively? I have real addresses
on both sides of the firewall, but want things like FTP to work
correctly. I think the IPChains HOWTOs are just a little terse. :)

Thanks!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
