Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284480AbRLEVx6>; Wed, 5 Dec 2001 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284526AbRLEVxm>; Wed, 5 Dec 2001 16:53:42 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:32518 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284480AbRLEVwT>; Wed, 5 Dec 2001 16:52:19 -0500
Date: Wed, 5 Dec 2001 22:37:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, marcelo@conectiva.com.br,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Trivial typo in comment, please apply
Message-ID: <20011205223755.A263@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yep, its simple.
								Pavel

--- clean//include/linux/shmem_fs.h	Wed Oct 10 16:53:57 2001
+++ linux-swsusp/include/linux/shmem_fs.h	Sat Nov 17 00:19:35 2001
@@ -11,7 +11,7 @@
  * swapper address space.
  *
  * We have to move it here, since not every user of fs.h is including
- * mm.h, but m.h is including fs.h via sched .h :-/
+ * mm.h, but mm.h is including fs.h via sched .h :-/
  */
 typedef struct {
 	unsigned long val;

-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
