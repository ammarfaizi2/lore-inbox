Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSIWXC7>; Mon, 23 Sep 2002 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSIWXC7>; Mon, 23 Sep 2002 19:02:59 -0400
Received: from u212-239-128-15.dialup.planetinternet.be ([212.239.128.15]:10244
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S261475AbSIWXC6>; Mon, 23 Sep 2002 19:02:58 -0400
Message-Id: <200209232306.g8NN6efH009834@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38 
In-Reply-To: Your message of "Sun, 22 Sep 2002 19:27:18 PDT."
             <Pine.LNX.4.44.0209221924210.1208-100000@home.transmeta.com> 
Date: Tue, 24 Sep 2002 01:06:40 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That may just be due to the new mouse driver and/or input layer, which 
> went in some weeks ago. What kind of mouse 

Yep, I've suspected this to be input related from the start.That would
fit the timing perfectly.

It's a plain old serial mouse, no PS/2. It works fine with gpm, only
X locks up. Or to be entirely accurate: X consistently locks up almost 
immediately, whereas gpm survived all testing until now.

MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a37 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

