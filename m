Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268347AbTCCHD5>; Mon, 3 Mar 2003 02:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTCCHD5>; Mon, 3 Mar 2003 02:03:57 -0500
Received: from [196.12.44.6] ([196.12.44.6]:10199 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S268347AbTCCHD4>;
	Mon, 3 Mar 2003 02:03:56 -0500
Date: Mon, 3 Mar 2003 12:46:02 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: redirecting printk to the Serial port
Message-ID: <Pine.LNX.4.44.0303031242150.24054-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	Got a silly doubt. when trying to insert one of my modules into
the kernel, its getting rebooted and unfortunately i am losing all the
debug(printk) messages.  Can i in some fashion capture all the printk's
through the serial port. (I have two linux boxes and a serial cable to
connect both of them)

Thanx in advance
Prasad.

-- 
Failure is not an option

