Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRCTWY4>; Tue, 20 Mar 2001 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRCTWYr>; Tue, 20 Mar 2001 17:24:47 -0500
Received: from chaos.ao.net ([205.244.242.21]:31749 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S131079AbRCTWYh>;
	Tue, 20 Mar 2001 17:24:37 -0500
Message-Id: <200103202223.f2KMNnN22219@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: Re: AMI MegaRAID support in 2.4.3-pre4 
Date: Tue, 20 Mar 2001 17:23:49 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (please cc: me any response, I only keep up with linux-kernel via the archives)

Dan Merillat writes:

> Apparently the chip is too new for driver version 1.07b, (not recognized
> at all by the kernel) and 1.14g has the problems I'm going over here.

An update... driver version 1e08 (stupid version number... 1.08e?) works,
but only on a 2.2.x kernel (2.2.18)  1e08 dosn't play nicely with 2.4.x
PCI scanning... compiles but never gets run.

I believe this is the version sent to RedHat.  Anyway, I can live with this,
since this particular box is single-CPU.  I'll have a SMP configuration on
another machine soon, though.

This box is available for another day or so for experimentation, before I wipe
the drive and do a final install.  If anyone has any ideas let me know now.

I can even give root level access to it for the moment. (again, it's getting
wiped in 48 hours)

--Dan

