Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUJDUbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUJDUbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUJDUbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:31:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:38614 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268379AbUJDUbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:31:48 -0400
Date: Mon, 4 Oct 2004 22:39:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry Ewing <lewing@isc.tamu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] How about making Tux official - it's about time...
Message-ID: <Pine.LNX.4.61.0410042223200.2925@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

By now it's been an ~8 year relationship between Linux and Tux, but 
Documentation/logo.txt still proclaim the poor bird as the unofficial 
logo. Isn't it about time Tux gained official status? I mean, the bird is 
practically everywhere, and there's no doubt that it's considered the 
Linux logo where ever you go.

You can hardly claim that you have "not really announced it yet" any more. 
I don't know about the paperwork bit, but if that's really something that 
should be done, then how about now for a good time to get it done so we 
can finally proclaim Tux as official? 

I propose the following patch :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.9-rc3-mm2-orig/Documentation/logo.txt linux-2.6.9-rc3-mm2/Documentation/logo.txt
--- linux-2.6.9-rc3-mm2-orig/Documentation/logo.txt	2004-09-30 05:04:23.000000000 +0200
+++ linux-2.6.9-rc3-mm2/Documentation/logo.txt	2004-10-04 22:28:44.000000000 +0200
@@ -1,8 +1,7 @@
-This is the full-colour version of the currently unofficial Linux logo
-("currently unofficial" just means that there has been no paperwork and
-that I have not really announced it yet).  It was created by Larry Ewing,
-and is freely usable as long as you acknowledge Larry as the original
-artist. 
+
+This is the full-colour version of the official Linux logo (Tux).
+It was created by Larry Ewing, and is freely usable as long as you 
+acknowledge Larry as the original artist. 
 
 Note that there are black-and-white versions of this available that
 scale down to smaller sizes and are better for letterheads or whatever



Also, on a related note; how about a PNG version instead of a GIF in the 
kernel source? PNG is a nice open format, GIF has this unpleasant patent 
smell...?


--
Jesper Juhl


