Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbSLLDqw>; Wed, 11 Dec 2002 22:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLLDqw>; Wed, 11 Dec 2002 22:46:52 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:13773 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267409AbSLLDqv>;
	Wed, 11 Dec 2002 22:46:51 -0500
Message-ID: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie>
Date: Thu, 12 Dec 2002 03:54:05 -0000 (GMT)
Subject: 2.4.20-ac2 and i810 drm
From: "Dave Airlie" <airlied@linux.ie>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <alan@lxorguk.ukuu.org.uk>
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been running 2.4.20-rc4 up to now with DRM enabled for my i810
chipset and XFree86 4.2 from RH 7.3.

When I run my OpenGL application (internal app) under 2.4.20-ac2 with the
same .config when I ctrl-c the application the machine hangs hard.

It is the only application running on the X server so the X server
restarts when I exit the app.. under 2.4.20-rc4 this works fine...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person



