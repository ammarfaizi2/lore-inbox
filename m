Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267086AbUBMP6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267088AbUBMP6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:58:40 -0500
Received: from ponzi.oit.umass.edu ([128.119.166.18]:20187 "EHLO
	ponzi.oit.umass.edu") by vger.kernel.org with ESMTP id S267086AbUBMP6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:58:38 -0500
Date: Fri, 13 Feb 2004 10:38:24 -0500
From: Venkata Avasarala <venkata@acad.umass.edu>
Subject: Profiling linux kernel.
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Reply-to: venkata@acad.umass.edu
Message-id: <1076686703.2153.12.camel@invincible>
Organization: University of Massachusetts,Amherst.
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am trying to profile the linux kernel. I booted the kernel with
"profile=2" command line option and I am reading the /proc/profile using
the readprofile command. The result I couldn't quite understand the
result I got. The result shows that the kernel is spending a lot of time
the machine_retstart function. One would normally think that the machine
restart function is only invoked once.
The kernel version I am using is 2.4.9-21 on an i386 platform.
Any help in understanding the issue is appreciated.
Thanks,
Venkata.
-- 
Venkata Avasarala
Research Assistant
Architecture and Real Time Systems Lab
University of Massachusetts,Amherst.

