Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSIDFpw>; Wed, 4 Sep 2002 01:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSIDFpw>; Wed, 4 Sep 2002 01:45:52 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:10372 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319064AbSIDFpw>; Wed, 4 Sep 2002 01:45:52 -0400
Date: Tue, 3 Sep 2002 23:50:11 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <17mNlP-13yuauC@fmrl03.sul.t-online.com>
Message-ID: <Pine.LNX.4.44.0209032349150.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Sep 2002, Oliver Neukum wrote:
> No, it's always a problem. You need to record somewhere, what you use
> which disk for. If these recordings need to be changeable on a live
> system, you need to make sure that they are always in a consistent
> state.

Yes. And for a workstation system it makes sense to store that on top of 
the disk. But not exactly on raid.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

