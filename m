Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131786AbRAXMcP>; Wed, 24 Jan 2001 07:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131783AbRAXMcF>; Wed, 24 Jan 2001 07:32:05 -0500
Received: from coruscant.franken.de ([193.174.159.226]:63238 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S131786AbRAXMby>; Wed, 24 Jan 2001 07:31:54 -0500
Date: Wed, 24 Jan 2001 13:30:42 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Scaramanga <scaramanga@barrysworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewall netlink question...
Message-ID: <20010124133042.V6055@coruscant.gnumonks.org>
In-Reply-To: <20010122073343.A3839@lemsip.lan> <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de> <20010122102600.A4458@lemsip.lan> <E14Kf9W-0008PJ-00@kabuki.eyep.net> <20010122115826.A11297@lemsip.lan> <20010124042826.A3452@lemsip.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124042826.A3452@lemsip.lan>; from scaramanga@barrysworld.com on Wed, Jan 24, 2001 at 04:28:26AM +0000
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 04:28:26AM +0000, Scaramanga wrote:
> 
> On 2001.01.22 11:58:26 +0000 Scaramanga wrote:
> > I wonder, would there be any interest/point in my NETLINK module, which
> > provides a backward compatible netlink interface. There are a good few
> > apps out there which rely on it, and its nice not to have to run a daemon
> > and install a new library, and re-write them just to continue using them...
> 
> Well, here it is, kernel module, and iptables plugin. Emjoy :)

eeks... a compressed archie including a binary is not what people on 
linux-kernel usually want to see....

anyway - thanks for your contribution. Why didn't you submit this for 
inclusion into netfilter/iptables CVS patch-o-matic ? We (the netfilter
people) keep all the new targets/matches/... there and submit approved
stuff after some time for inclusion to the main kernel.

I'll do some testing and put it into CVS, if you want to.

> // Gianni Tedesco <scaramanga@barrysworld.com>

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
