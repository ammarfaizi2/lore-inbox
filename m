Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSL1Fbk>; Sat, 28 Dec 2002 00:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSL1Fbk>; Sat, 28 Dec 2002 00:31:40 -0500
Received: from mnh-1-09.mv.com ([207.22.10.41]:51460 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265190AbSL1Fbj>;
	Sat, 28 Dec 2002 00:31:39 -0500
Message-Id: <200212280544.AAA06441@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.53-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 00:44:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.5.53.  As far as UML itself is concerned,
this is identical to all recent 2.5 UML releases, except that I tossed in
a small fix for a race involving multiple xterms popping up at once.

I'm in the process of merging my recent 2.4 changes into my 2.5 tree, but
I figured I'd get this patch out first.

The 2.5.53 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.53-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
				Jeff

