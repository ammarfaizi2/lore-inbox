Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277565AbRJHW1P>; Mon, 8 Oct 2001 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277563AbRJHW04>; Mon, 8 Oct 2001 18:26:56 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:9222 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S277531AbRJHW0g>;
	Mon, 8 Oct 2001 18:26:36 -0400
Date: Tue, 9 Oct 2001 00:27:18 +0200 (CEST)
From: kernel@ddx.a2000.nu
To: "David S. Miller" <davem@redhat.com>
cc: Thomas.Duffy.99@alumni.brown.edu, <joelja@darkwing.uoregon.edu>,
        <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>
Subject: Re: sun + gigabit nic
In-Reply-To: <20011008.151119.104032462.davem@redhat.com>
Message-ID: <Pine.LNX.4.40.0110090019140.28619-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, David S. Miller wrote:

>    From: kernel@ddx.a2000.nu
>    Date: Tue, 9 Oct 2001 00:07:29 +0200 (CEST)
>
>    so any gigabit copper cards that DO work under sparc64 ?
>
> Syskonnect and copper Acenic's work just fine.  I see copper netgear
> Acenics all the time here locally at Fry's for around $300 USD.

Ok then i quote Thomas Duffy (about the GA622T) :

> this is netgear's gige over copper card. it does not use the acenic
> chip.  instead it uses the national semiconductor 83820 chip and a
> different driver. this driver did not go into the kernel until ~2.4.10
> (ns83820.c) and does not work under sparc64 so far -- it seems to

so about which netgear card are you talking ?

on netgear.com i see 3 copper cards :

GA620T, GA621T and GA622T

but on the online store i only see the GA622T (so it looks like the other
2 are end of life or something?)

