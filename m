Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTAEMmo>; Sun, 5 Jan 2003 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbTAEMmo>; Sun, 5 Jan 2003 07:42:44 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:43536 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S264706AbTAEMmn>;
	Sun, 5 Jan 2003 07:42:43 -0500
Message-ID: <001001c2b4b9$467de380$e56114d4@DEFAULT>
From: "=?iso-8859-2?B?VG9t4bkgVm9uZHJh?=" <wondra@volny.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: Booting problem on LOOPback device
Date: Sun, 5 Jan 2003 13:52:15 +0100
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


