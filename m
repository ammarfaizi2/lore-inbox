Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVAHICd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVAHICd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVAHHvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:51:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:36485 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261844AbVAHFsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:10 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163258285@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <11051632591441@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.3, 2004/12/15 10:51:58-08:00, greg@kroah.com

Documentation: fix some grammer in the stable_api_nonsense.txt file

Thanks to Andries Brouwer <aebr@win.tue.nl> for pointing this out.


 Documentation/stable_api_nonsense.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/stable_api_nonsense.txt b/Documentation/stable_api_nonsense.txt
--- a/Documentation/stable_api_nonsense.txt	2005-01-07 15:51:52 -08:00
+++ b/Documentation/stable_api_nonsense.txt	2005-01-07 15:51:52 -08:00
@@ -9,7 +9,7 @@
 kernel to userspace interfaces.  The kernel to userspace interface is
 the one that application programs use, the syscall interface.  That
 interface is _very_ stable over time, and will not break.  I have old
-programs that were built on a pre 0.9something kernel that still works
+programs that were built on a pre 0.9something kernel that still work
 just fine on the latest 2.6 kernel release.  This interface is the one
 that users and application programmers can count on being stable.
 
@@ -167,7 +167,7 @@
 ensures that your driver is always buildable, and works over time, with
 very little effort on your part.
 
-The very good side affects of having your driver in the main kernel tree
+The very good side effects of having your driver in the main kernel tree
 are:
   - The quality of the driver will rise as the maintenance costs (to the
     original developer) will decrease.

