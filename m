Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTAQR3e>; Fri, 17 Jan 2003 12:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTAQR3d>; Fri, 17 Jan 2003 12:29:33 -0500
Received: from bay2-dav69.bay2.hotmail.com ([65.54.246.204]:33031 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S267534AbTAQR3d>;
	Fri, 17 Jan 2003 12:29:33 -0500
X-Originating-IP: [24.186.227.45]
From: "Mark F." <daracerz@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.59 - Compaq 900z - No Go..
Date: Fri, 17 Jan 2003 11:49:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <BAY2-DAV69nJkxWwBvt0000440f@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2003 17:38:26.0263 (UTC) FILETIME=[3D75F670:01C2BE4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

After trying the recent latest release, the compilation mode is an ok except
for some warning and module install issues.
Anyways, when I configure the kernel into the boot loader, and I try to boot
it up it fails after each repeated attempt.  All that happens is that it
starts the Kernel Boot Up, gets to the line that says "Uncompressing
Kernel...." and the it just hard reboots the computer.  Does this after each
repeated chance.  Currently trying to play around with whch drivers I am
loading into the kernel to see if I am able to eliminate something

Computer is basically an AMD Athlon 1600 with the Radeon IGP Chipset for
those who don't know.  (Yes, with previous builds, think was 2.5.54 is
booted, and works on 2.4.21-pre3)

Mark
