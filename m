Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSIBWfZ>; Mon, 2 Sep 2002 18:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSIBWfZ>; Mon, 2 Sep 2002 18:35:25 -0400
Received: from pD952A8C0.dip.t-dialin.net ([217.82.168.192]:20865 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318526AbSIBWfY>; Mon, 2 Sep 2002 18:35:24 -0400
Date: Mon, 2 Sep 2002 16:39:53 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       <Andries.Brouwer@cwi.nl>, <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
       <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <Pine.LNX.4.44.0209021501080.1401-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209021638230.3270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Linus Torvalds wrote:
> On Mon, 2 Sep 2002, Thunder from the hill wrote:
> > 
> > Why not the faraway goal: no partition tables any more? They're annoying.
> 
> Guys, Linux is not a research project.
> 
> Partition tables are a fact of life.

Linus, can you spell "faraway"? I wasn't talking about kicking 
partitioning code from Linux 2.5, I was talking about inventing a better 
way in 2010.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

