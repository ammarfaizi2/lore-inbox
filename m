Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJRFVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJRFVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:21:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52688
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261344AbTJRFVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:21:19 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Where's the bzip2 compressed linux-kernel patch?
Date: Sat, 18 Oct 2003 00:18:21 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310180018.21818.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just rewrote bunzip2 for busybox in about 500 lines of C (and a good chunk 
of that's comments), which comiles to a bit under 7k, and I was thinking of 
redoing the bunzip-the-kernel patch with my new bunzip code, but I can't find 
the patch.  Anybody got a URL to it?

The most recent one I could find was kerneltrap's 404-error link to 
http://chrissicool.piranho.com/patch-2.4.x-bzip2-i386

Rob

P.S.  If you're curious about the micro-bunzip code, it's in busybox CVS:
http://www.busybox.net/cgi-bin/cvsweb/busybox/archival/libunarchive/decompress_bunzip2.c
