Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSGLOWy>; Fri, 12 Jul 2002 10:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGLOWx>; Fri, 12 Jul 2002 10:22:53 -0400
Received: from conn6m.toms.net ([64.32.246.219]:32725 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S316535AbSGLOWx>;
	Fri, 12 Jul 2002 10:22:53 -0400
Date: Fri, 12 Jul 2002 10:25:37 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Daniel Phillips <phillips@arcor.de>
cc: Christian Ludwig <cl81@gmx.net>, Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
In-Reply-To: <E17SwAM-0002e2-00@starship>
Message-ID: <Pine.LNX.4.44.0207121023300.23208-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you really?  Why?  Exactly what purpose does it serve to know how your
> kernel was compressed, considering that it knows how to uncompress itself?

I already use the name in scripts for tomsrtbt to decide whether the ramdisk
should be compressed with bzip2 or gzip, since the kernel compression method
(in my original patch) determines the required ramdisk compression.

-Tom

