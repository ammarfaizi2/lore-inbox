Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbRE2Q7K>; Tue, 29 May 2001 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRE2Q7B>; Tue, 29 May 2001 12:59:01 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261335AbRE2Q6v>;
	Tue, 29 May 2001 12:58:51 -0400
Message-ID: <20010529180844.A21119@bug.ucw.cz>
Date: Tue, 29 May 2001 18:08:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: alan@redhat.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Spelling fix in slab.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I know it is not important, but anyway:

								Pavel

Index: slab.h
===================================================================
RCS file: /home/cvs/Repository/linux/include/linux/slab.h,v
retrieving revision 1.1.1.2
diff -u -u -r1.1.1.2 slab.h
--- slab.h	2001/04/19 20:00:39	1.1.1.2
+++ slab.h	2001/05/29 15:07:17
@@ -29,7 +29,7 @@
  * The first 3 are only valid when the allocator as been build
  * SLAB_DEBUG_SUPPORT.
  */
-#define	SLAB_DEBUG_FREE		0x00000100UL	/* Peform (expensive) checks on free */
+#define	SLAB_DEBUG_FREE		0x00000100UL	/* Perform (expensive) checks on free */
 #define	SLAB_DEBUG_INITIAL	0x00000200UL	/* Call constructor (as verifier) */
 #define	SLAB_RED_ZONE		0x00000400UL	/* Red zone objs in a cache */
 #define	SLAB_POISON		0x00000800UL	/* Poison objects */

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
