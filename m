Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292850AbSCKGJx>; Mon, 11 Mar 2002 01:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292972AbSCKGJm>; Mon, 11 Mar 2002 01:09:42 -0500
Received: from coruscant.franken.de ([193.174.159.226]:36587 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S292850AbSCKGJZ>; Mon, 11 Mar 2002 01:09:25 -0500
Date: Mon, 11 Mar 2002 07:07:36 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: skraw@ithnet.com, joe@tmsusa.com, linux-kernel@vger.kernel.org,
        elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020311070736.P16784@sunbeam.de.gnumonks.org>
In-Reply-To: <3C6D1E99.6070303@tmsusa.com> <20020227151218.78965262.skraw@ithnet.com> <20020310163339.H16784@sunbeam.de.gnumonks.org> <20020310.164113.01028736.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020310.164113.01028736.davem@redhat.com>; from davem@redhat.com on Sun, Mar 10, 2002 at 04:41:13PM -0800
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 68th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 04:41:13PM -0800, David Miller wrote:
>    From: Harald Welte <laforge@gnumonks.org>
>    Date: Sun, 10 Mar 2002 16:33:39 +0100
>    
>    You can buy bcm57xx based boards, where the chipset is nice but the driver
>    not really nice yet.
>    
> My tg3 driver sucks then right?  Could you send me a bug report?

As stated in the other mail to Jeff Garzik, I was talking about the bcm57xx
driver, _NOT_ about the new tg3.  Sorry for not making this clear in the
original mail.

> The hardware is not capable of doing it, due to bugs in the hw
> checksum implementation of the sk98 chipset.  They aren't being
> "slow" they just can't possibly implement it for you.

Ouch. Thanks for dropping me this note.

> David S. Miller

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
