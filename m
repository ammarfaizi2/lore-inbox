Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLTRBL>; Wed, 20 Dec 2000 12:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQLTRBC>; Wed, 20 Dec 2000 12:01:02 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:49210 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129585AbQLTRAt>; Wed, 20 Dec 2000 12:00:49 -0500
Message-ID: <3A40DE97.96228B5E@holly-springs.nc.us>
Date: Wed, 20 Dec 2000 11:30:15 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <3A40DBC2.AEC6B3CA@holly-springs.nc.us> <20001220112502.A10406@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" wrote:
>         I think that's more than a little overstatement on your
> part.  It depends entirely on the application you intend to put
> it to.  

Fine. How do I make FTP work through it? How can I allow all outgoing
TCP connections without opening the network to inbound connections on
the ports of desired services?

>         Yes it does.  It's clearly stated in all the documentation
> on netfilter and in it's design.  Read the fine manual (or web site)
> and you would have uncovered this (or been run over by it) for yourself.
> 
>         http://netfilter.filewatcher.org/

Thanks.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
