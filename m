Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292003AbSBOANM>; Thu, 14 Feb 2002 19:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292005AbSBOAMw>; Thu, 14 Feb 2002 19:12:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:4869 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S292003AbSBOAMl>; Thu, 14 Feb 2002 19:12:41 -0500
Date: Thu, 14 Feb 2002 19:12:33 -0500 (EST)
From: <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: computed checksums did NOT match
Message-ID: <Pine.LNX.4.30.0202141905280.2616-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'm running on the system, isn't that how you tell fatal errors, by
booting the kernel?

This came out of "make dep" and I'm not sure what it's telling me.

Tree is 2.4.18-pre9-ac3 with the ksyms.c patch, tried "make distclean"
pulling a 2.4.17 config and "make oldconfig" and still got this.

Not concerned, just curious.

After I run benchmarks on this last kernel I'm going to post some results
and comments on kernels for small and slow machines.
-- 
No sig file here, return address may be bogus.

