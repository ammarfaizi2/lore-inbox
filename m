Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269983AbTGLJLq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 05:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269997AbTGLJLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 05:11:46 -0400
Received: from mail-1.tiscali.it ([195.130.225.147]:9903 "EHLO
	mail-1.tiscali.it") by vger.kernel.org with ESMTP id S269983AbTGLJLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 05:11:37 -0400
Subject: Re: 2.5.75-kj1
From: Daniele Bellucci <bellucda@tiscali.it>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       kernel janitor ml 
	<kernel-janitor-discuss@lists.sourceforge.net>
In-Reply-To: <32820.4.4.25.4.1057997224.squirrel@www.osdl.org>
References: <32820.4.4.25.4.1057997224.squirrel@www.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Jul 2003 11:31:14 +0200
Message-Id: <1058088675.2273.1.camel@laptop.laptop.it>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il sab, 2003-07-12 alle 10:07, Randy.Dunlap ha scritto:
> 
> patch is at:
> http://developer.osdl.org/rddunlap/kj-patches/2.5.75/patch-2.5.75-kj1.bz2
> 
> changes since patch-2.5.74-kj1:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
....

Why isn't EXTRAVERSION changed to -kj1?


diff -urN 1.0/Makefile 1.1/Makefile
--- 1.0/Makefile	2003-07-13 11:29:15.000000000 +0200
+++ 1.1/Makefile	2003-07-13 11:29:30.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 75
-EXTRAVERSION =
+EXTRAVERSION = -kj1
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

