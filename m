Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263093AbRE1QmW>; Mon, 28 May 2001 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbRE1QmM>; Mon, 28 May 2001 12:42:12 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:49878 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263093AbRE1Ql6>;
	Mon, 28 May 2001 12:41:58 -0400
Date: Mon, 28 May 2001 12:41:57 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/kernel-docs.txt
Message-ID: <20010528124157.C30332@somanetworks.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010528122601.A945@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528122601.A945@somanetworks.com>; from mark@somanetworks.com on Mon, May 28, 2001 at 12:26:01PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, that was wrong.  The proper patch is:

--- Documentation/kernel-docs.txt.old   Mon May 28 12:06:43 2001
+++ Documentation/kernel-docs.txt       Mon May 28 12:37:26 2001
@@ -333,7 +333,8 @@
        
      * Title: "The Kernel Hacking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL: http://www.samba.org/~netfilter/kernel-hacking-HOWTO.html
+       URL: http://netfilter.gnumonks.org/unreliable-guides/kernel-hacking/
+               lk-hacking-guide.html
        Keywords: HOWTO, kernel contexts, deadlock, locking, modules,
        symbols, return conventions.
        Description: From the Introduction: "Please understand that I
@@ -393,9 +394,8 @@
        
      * Title: "Linux Kernel Locking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL:
-       http://netfilter.kernelnotes.org/unreliable-guides/kernel-locking-
-       HOWTO.html
+       URL: http://netfilter.gnumonks.org/unreliable-guides/kernel-locking/
+               lklockingguide.html
        Keywords: locks, locking, spinlock, semaphore, atomic, race
        condition, bottom halves, tasklets, softirqs.
        Description: The title says it all: document describing the

