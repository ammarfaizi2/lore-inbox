Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSL2NBH>; Sun, 29 Dec 2002 08:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbSL2NBH>; Sun, 29 Dec 2002 08:01:07 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:60174 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S266576AbSL2NBG>;
	Sun, 29 Dec 2002 08:01:06 -0500
Message-ID: <000101c2af3b$a0a515a0$ce6614d4@DEFAULT>
From: "=?iso-8859-2?B?VG9t4bkgVm9uZHJh?=" <wondra@volny.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Booting problem on LOOPback device
Date: Sun, 29 Dec 2002 14:10:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.2106.4
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.2 kernel and use RedHat's "Partitionless installation" - the root
is on a loopback device. I've compiled kernel 2.4.17, upgraded modutils and
e2fsprogs and the kernel doesn't want to boot properly - the last bootup
message is "Can't write to read-only device 7,0", the kernel continues, but
the root can't be remounted rw (I've tried it in single-user mode). If I put
'rw' to the kernel command line, it's possible to write to the root
device(in single mode). I don't know it for sure right now, but I think that
the error message remains.
Please tell me somebody where the problem could be.
reply to wondra@volny.cz for I'm not a member

