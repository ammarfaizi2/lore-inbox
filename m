Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130877AbRAADjy>; Sun, 31 Dec 2000 22:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbRAADjp>; Sun, 31 Dec 2000 22:39:45 -0500
Received: from c954190-a.saltlk1.ut.home.com ([24.13.131.161]:34286 "EHLO
	newton.uucp") by vger.kernel.org with ESMTP id <S130696AbRAADjf>;
	Sun, 31 Dec 2000 22:39:35 -0500
Message-ID: <XFMail.20001231201053.thoth@leapdragon.net>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sun, 31 Dec 2000 20:10:53 -0700 (MST)
Organization: Bauhaus Weimar, 1919
From: Desert Dragon <thoth@leapdragon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prerelease & 2048-byte FAT sectors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just installed 2.4.0-prerelease, and it looks like FAT
filesystems on hardware 2048-byte sectors are still not
working.

Are there any plans to fix this, or should I consider
such devices obsolete? I'm keeping 2.2.17 around and
rebooting every time I have to access my MO drives --
rather inconvenient.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
