Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268338AbTBNKMg>; Fri, 14 Feb 2003 05:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268349AbTBNKM3>; Fri, 14 Feb 2003 05:12:29 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:38845 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S268338AbTBNKM1>;
	Fri, 14 Feb 2003 05:12:27 -0500
Date: Fri, 14 Feb 2003 11:21:41 +0100 (CET)
From: kernel@ddx.a2000.nu
To: Mike Black <mblack@csi-inc.com>
cc: Stephan van Hienen <raid@a2000.nu>, Peter Chubb <peter@chubb.wattle.id.au>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       bernard@biesterbos.nl, ext2-devel@lists.sourceforge.net
Subject: Re: raid5 2TB+ NO GO ?
In-Reply-To: <044101c2d2a9$4fcdf980$f6de11cc@black>
Message-ID: <Pine.LNX.4.53.0302141120230.19336@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302060059210.6169@ddx.a2000.nu>
 <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu> <Pine.LNX.4.53.0302060211030.6169@ddx.a2000.nu>
 <15937.50001.367258.485512@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.53.0302061915390.17629@ddx.a2000.nu>
 <15945.31516.492846.870265@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.53.0302121129480.13462@ddx.a2000.nu> <044101c2d2a9$4fcdf980$f6de11cc@black>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Mike Black wrote:

> I did a 12x180G and as I recall was unable to do 13x180G as it overflowed during mke2fs.  This was a year ago though so I don't know
> if that's been improved since then.
>

does anyone know for sure what is the limit for md raid5 ?

can i use 13*180GB in raid5 ?
or should i go for 12*180GB in raid5 ?
