Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314385AbSDVSMa>; Mon, 22 Apr 2002 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSDVSM3>; Mon, 22 Apr 2002 14:12:29 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:61799 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S314385AbSDVSM2>; Mon, 22 Apr 2002 14:12:28 -0400
Date: Mon, 22 Apr 2002 19:19:53 +0100
From: Ian Molton <spyro@armlinux.org>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: phillips@bonn-fries.net, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-Id: <20020422191953.034f51d4.spyro@armlinux.org>
In-Reply-To: <31CB8B22019@vcnet.vc.cvut.cz>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec Awoke this dragon, who will now respond:

> 
>  Why we have kernel tarball at all, then? Just put URLs where you can 
>  download different pieces of kernel, and we are done. You finally

Actually, the kernel tarball is full of crap we dont need.

Sooner or later its going to get too big and be split up into

core kernel
drivers (drivers/net, drivers/video etc.)
arch specifics
documentation

all for seperate download.
