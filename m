Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315600AbSENKjf>; Tue, 14 May 2002 06:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315603AbSENKje>; Tue, 14 May 2002 06:39:34 -0400
Received: from a217-118-40-108.bluecom.no ([217.118.40.108]:45329 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S315600AbSENKjd>; Tue, 14 May 2002 06:39:33 -0400
Message-ID: <016f01c1fb33$d97baef0$8f2b76d9@dead2>
From: "Hans K. Rosbach" <hk@circlestorm.org>
To: <linux-kernel@vger.kernel.org>
Subject: Initrd or Cdrom as root
Date: Tue, 14 May 2002 12:41:05 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to dynamically load initrd or cdrom permanently as
the root fs when booting from cdrom?

My problem is that I need a reliable way to ALWAYS find the correct
device to mount. Is there any way to make the kernel automagically
mount the cdrom it booted from?
I believe that for example SuSE installer cd does this, but I cannot figure
out how they do it.

If on initrd, I need about 300MB space on the root fs.

If this is not possible, what do I need to modify in the kernel?

-HKR

