Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSFKSzP>; Tue, 11 Jun 2002 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSFKSzO>; Tue, 11 Jun 2002 14:55:14 -0400
Received: from [24.71.173.70] ([24.71.173.70]:52112 "EHLO
	valhalla.homelinux.org") by vger.kernel.org with ESMTP
	id <S317506AbSFKSzO>; Tue, 11 Jun 2002 14:55:14 -0400
Date: Tue, 11 Jun 2002 12:53:07 -0600 (CST)
From: "Jason C. Pion" <jpion@valhalla.homelinux.org>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <002101c2115d$1c0bc7c0$baefb0d4@nick>
Message-ID: <Pine.LNX.4.44.0206111243560.2457-100000@valhalla.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Nick Evgeniev wrote:

> Agreed. But all what I see is that STABLE Linux kernel DOESN'T has working
> driver for promise controller (including latest ac patches) for SEVERAL
> MONTHS.
<SNIP> 
> I don't want to make experiments in production environment anymore... And
> it's
> unfair to the rest of Linux users to keep broken drivers in stable kernel...
> Because
> nobody expects that stable kernel will rip your fs _daily_.

It sounds to me like you've got some flakey hardware.  Don't try to save 
the rest of us.  I've been using the Promise drivers with my Ultra 133TX2 
for quite a while now and haven't had _ANY_ problems with it.  I've used 
all of the 2.4.19preXX kernels so far with now issues.  This "problem" 
isn't as wide-spread as you think.

Later,
	Jason


