Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWDXOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDXOVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWDXOVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:21:35 -0400
Received: from abner.srv.ualberta.ca ([142.244.12.160]:39568 "EHLO
	abner.srv.ualberta.ca") by vger.kernel.org with ESMTP
	id S1750792AbWDXOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:21:34 -0400
Message-ID: <20060424082133.ry4bb8d1c0sg88so@webmail.ualberta.ca>
X-IMAP-User: sbhalla
X-IMAP-Server: 142.244.12.147
Date: Mon, 24 Apr 2006 08:21:33 -0600
From: sbhalla@ualberta.ca
To: linux-kernel@vger.kernel.org
Subject: Frequent Kernel Panic on my system
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



I have a Sony Vaio running Fedora Core 3 (Kernel version 2.6). For some 
reason, often the laptop just hangs and the kernel panics. The panic 
messages captured are:



Process xinetd (pid: 2123, threadinfo=023d4000 task=1f20f370)

Stack: 023d4fd0 06350d40 02350d40 00000000 00000011 023fa5a8 0000000a 
00000000 02124f09 1fc91f40 00000046 023d5000 021096ee



Call Trace:

Stack Pointer in garbage, not printing trace

Code: Bad EIP value.

kernel/timer.c:194: spin_lock(kernel/timer.c:02350760) already locked 
by kernel/timer.c/439

Kernel panic - not syncing: Fatal exception in interrupt



It would be great help if someone could please tell what might have 
possibly gone wrong with my system.



Thanks

Shallu

