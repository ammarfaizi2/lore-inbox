Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTJUD40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 23:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTJUD40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 23:56:26 -0400
Received: from web14908.mail.yahoo.com ([216.136.225.60]:28841 "HELO
	web14908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262894AbTJUD4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 23:56:25 -0400
Message-ID: <20031021035624.42271.qmail@web14908.mail.yahoo.com>
Date: Mon, 20 Oct 2003 20:56:24 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: linux-gate.so and gdb
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I convince gdb to stop breaking on linux-gate.so?

(gdb) cont 
Error while reading shared library symbols:
linux-gate.so.1: No such file or directory.
[Switching to Thread 1074348256 (LWP 15609)]
Stopped due to shared library event
(gdb) cont 
Stopped due to shared library event
Error while reading shared library symbols:
linux-gate.so.1: No such file or directory.
(gdb) cont 
Error while reading shared library symbols:
linux-gate.so.1: No such file or directory.
Stopped due to shared library event
(gdb) cont 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
