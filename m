Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSLPTf3>; Mon, 16 Dec 2002 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLPTf3>; Mon, 16 Dec 2002 14:35:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46447 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S261206AbSLPTf2>; Mon, 16 Dec 2002 14:35:28 -0500
Date: Mon, 16 Dec 2002 14:31:22 -0500
From: Xavier LaRue <paxl@videotron.ca>
Subject: Re: L2 Cache problem
In-reply-to: <Pine.LNX.4.33.0212161347580.25857-100000@router.windsormachine.com>
To: linux-kernel@vger.kernel.org
Message-id: <20021216143122.31ba9a0f.paxl@videotron.ca>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20021216133016.64c75cac.paxl@videotron.ca>
 <Pine.LNX.4.33.0212161347580.25857-100000@router.windsormachine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002 13:56:09 -0500 (EST)
Mike Dresser <mdresser_l@windsormachine.com> wrote:

> On Mon, 16 Dec 2002, Xavier LaRue wrote:
> 
> > my dmesg will be online at http://paxl.no-ip.org/~paxl/dmesg.txt if somone mind.
> >
> >
> > Another fuzzy thing .. compiling my kernel normaly ( -j 1 ) take 30min
> > and when I make it with -j 2/8/16 it take 25min, I think this is due to
> > my L2 cache problem but that not normal, if somone have an idea.. I
> > should be realy interested.
> 
> sounds like you've got your l2 turned off in the bios to me.

There is no option in my bios to enable or disable L2 cache..
And at boot I get this

DSP Microcode OK ...... L2 512KB OK
AS#1 Microcode OK ...... L2 512KB OK

So I assume that the bios enable it, do there is a way to Force the kernel to use it even if he can't detect it ??

Thank you for your time and answer :)
Xavier LaRue
