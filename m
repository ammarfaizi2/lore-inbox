Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbQJaEUl>; Mon, 30 Oct 2000 23:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbQJaEUb>; Mon, 30 Oct 2000 23:20:31 -0500
Received: from dial-09-29-apx-02.btvt.together.net ([209.91.32.29]:18822 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S130162AbQJaEUS>; Mon, 30 Oct 2000 23:20:18 -0500
Date: Mon, 30 Oct 2000 23:20:00 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: Gerhard Fuellgrabe <gerd@cacofonix.harz.de>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: ip_masq module for battlecom?
In-Reply-To: <20001030214820.A13204@cacofonix.fuenet.harz.de>
Message-ID: <Pine.LNX.4.21.0010302317410.1267-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening, Gerhard,

On Mon, 30 Oct 2000, Gerhard Fuellgrabe wrote:

> in my LAN there are users working on battle.net (Starcraft,
> Diablo2 etc.). There is a Linux 2.2.14 box routing the LAN
> with private IP addresses to the internet (with IP masqerading).
> 
> A feature that does not work is the battlecom communication. 
> Is there an ip_masq module available for this (like e.g. 
> ipv4/ip_masq_cuseeme.o or ipv4/ip_masq_quake.o) or is anybody
> working on this?

	See the "Application Support" link at http://ipmasq.cjb.net for
information about specific applications under masquerading.
	Future questions about masquerade support should go to the
ip-masq mailing list; info on that list can also be found at the above
link.
	Best of luck.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Put down those Windows disks, Dave..."
	-- HAL
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
