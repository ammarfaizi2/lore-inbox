Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUINCeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUINCeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUINCcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:32:47 -0400
Received: from holomorphy.com ([207.189.100.168]:9104 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269130AbUINC2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:28:31 -0400
Date: Mon, 13 Sep 2004 19:28:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, andrea@novell.com
Subject: [pidhashing] [1/3] retain older vendor copyright
Message-ID: <20040914022827.GP9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914022530.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914022530.GO9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
>> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
>>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
>> and will later appear at
>>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/
>> Please check kernel.org before using zip.com.au.

On Mon, Sep 13, 2004 at 07:25:30PM -0700, William Lee Irwin III wrote:
> The following 3 updates address various issues expressed to me in
> unrelated threads or messages, and while none of them are particularly
> pressing each does resolve a concern I've deemed valid.

I was informed that the vendor component of the copyright can't be
clobbered without more care, so this patch retains the older vendor,
updating it only to reflect the appropriate time period.

Index: mm5-2.6.9-rc1/kernel/pid.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/pid.c	2004-09-13 16:27:52.608819456 -0700
+++ mm5-2.6.9-rc1/kernel/pid.c	2004-09-13 16:30:21.980111568 -0700
@@ -1,7 +1,8 @@
 /*
  * Generic pidhash and scalable, time-bounded PID allocator
  *
- * (C) 2002-2004 William Irwin, Oracle
+ * (C) 2002-2003 William Irwin, IBM
+ * (C) 2004 William Irwin, Oracle
  * (C) 2002-2004 Ingo Molnar, Red Hat
  *
  * pid-structures are backing objects for tasks sharing a given ID to chain
