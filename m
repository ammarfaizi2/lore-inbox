Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSLGFz1>; Sat, 7 Dec 2002 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbSLGFz0>; Sat, 7 Dec 2002 00:55:26 -0500
Received: from mnh-1-28.mv.com ([207.22.10.60]:25606 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264859AbSLGFz0>;
	Sat, 7 Dec 2002 00:55:26 -0500
Message-Id: <200212070607.BAA05710@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@sourceforge.net
Subject: uml-patch-2.5.50-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 07 Dec 2002 01:07:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.5.50.  As far as UML itself is concerned, this
is identical to 2.5.49.

NOTE: I get reproducable filesystem corruption with this version.  Offhand,
it doesn't look like my fault, so I'm releasing it anyway.  I didn't notice
any such complaints (or fixes) about 2.5.50 on lkml, but it's possible I
wasn't paying enough attention.  If there is a fix, apply it first.  If not,
then run this version on a filesystem that you can afford to have trashed.

The 2.5.50 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.50-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
				Jeff

