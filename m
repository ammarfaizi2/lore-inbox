Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279250AbRJ2MQE>; Mon, 29 Oct 2001 07:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRJ2MP4>; Mon, 29 Oct 2001 07:15:56 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:63527 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S279250AbRJ2MO4>; Mon, 29 Oct 2001 07:14:56 -0500
Message-ID: <019d01c16073$299f5d20$0242a8c0@alpha.de>
From: "Frank Peters" <frank@zur-boersch.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: How to access /proc/*/mem ?
Date: Mon, 29 Oct 2001 13:13:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.10

I do a PTRACE_ATTACH to the process and I can open /proc/*/mem, but I can't
read on the fd.

I need to search for a specific value in the process memory and i wan't do a
lot of
PTRACE_PEEKTEXT!

Can someone point me to the right way?

THX
Frank Peters


