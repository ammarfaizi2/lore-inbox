Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQL1AVg>; Wed, 27 Dec 2000 19:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbQL1AV0>; Wed, 27 Dec 2000 19:21:26 -0500
Received: from 209.102.21.2 ([209.102.21.2]:2315 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129507AbQL1AVO>;
	Wed, 27 Dec 2000 19:21:14 -0500
Message-ID: <3A4A4FCD.C5208CAF@goingware.com>
Date: Wed, 27 Dec 2000 20:23:41 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI: S5 failed in 2.4.0-test13-pre4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a "shutdown -h now" in Slackware 7.1 with the
2.4.0-test13-pre4 kernel, sometimes after the words "Power down" appear
I get the message:

ACPI: S5 Failed

(I think that's the phrasing, of course since it only happens when I
shutdown for the night my memory is a little fuzzy).

It doesn't appear to cause any actual trouble but I thought I should
report it because it's out of the ordinary.

This is with an ASUS p3v4x mothboard, Pentium III 667 MHz, 128 MB 133
MHz ram, Adaptec 29160 Ultra160 SCSI Host Bus Adapter.  It has an
ATI XPert 2000 video card with AGP and DRM enabled in the kernel.
The kernel is built for SMP but it's not an SMP motherboard.

Mike

Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
