Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131215AbRBVDel>; Wed, 21 Feb 2001 22:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131217AbRBVDeb>; Wed, 21 Feb 2001 22:34:31 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:24105 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131215AbRBVDeT>; Wed, 21 Feb 2001 22:34:19 -0500
Date: Wed, 21 Feb 2001 22:33:28 -0500
From: Richard A Nelson <kenpocowboy@mindspring.com>
Message-Id: <200102220333.f1M3XSe6007701@back40.badlands.mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1[w,w/o -acx] and XF86 4.0.2 Matrox (Mystique) driver pblm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone else seen SEGVs from this combination ?

/var/log/xdm.log is less than helpfull, only mentioning that VC7 (I run
X on 3 VCs) had a Signal 11.

I've not yet identified whats running on VC7, and not on VC8-9 that might
be causing this...  Wish xdm gave a little more information...

Sigh, back to 2.2.19prex on this box (the rest of my boxen are running
2.4.1-ac20 w/o problem (ok, except for the olympic.c nit)

Thanks,
-- 
Rick Nelson
