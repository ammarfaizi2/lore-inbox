Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277176AbRJHWGp>; Mon, 8 Oct 2001 18:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277172AbRJHWGg>; Mon, 8 Oct 2001 18:06:36 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:58629 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S277170AbRJHWGc>;
	Mon, 8 Oct 2001 18:06:32 -0400
Date: Tue, 9 Oct 2001 00:07:29 +0200 (CEST)
From: kernel@ddx.a2000.nu
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        <sparclinux@vger.kernel.org>
Subject: Re: sun + gigabit nic
In-Reply-To: <1002559480.2837.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0110090001300.28619-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Oct 2001, Thomas Duffy wrote:

> On Sat, 2001-10-06 at 09:44, kernel@ddx.a2000.nu wrote:
>
> > so will the netgear gigabit adapter work with the ultrasparc linux kernel
> > ?
> > (the netgear ga622t ?)
>
> this is netgear's gige over copper card. it does not use the acenic
> chip.  instead it uses the national semiconductor 83820 chip and a
> different driver. this driver did not go into the kernel until ~2.4.10
> (ns83820.c) and does not work under sparc64 so far -- it seems to

so any gigabit copper cards that DO work under sparc64 ?
i looked at the intel source (on support.intel.com)
but it gives me some errors when i try to compile it on sparc

what about the 3Com 3C996-T ? (which has also drivers for linux on the
support page)


