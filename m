Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRCXR0K>; Sat, 24 Mar 2001 12:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131725AbRCXR0A>; Sat, 24 Mar 2001 12:26:00 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:5712 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131724AbRCXRZs>; Sat, 24 Mar 2001 12:25:48 -0500
Date: Sat, 24 Mar 2001 18:29:08 +0100
From: Alex Riesen <vmagic@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: tmpfs: a way to get your system down
Message-ID: <20010324182908.B1255@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

just hit by tmpfs on 2.4.2-ac20

mount -t tmpfs mnt
dd if=/dev/zero mnt/tmpfile

resulted in hardly slowed system and lockup,
and not in "No space left on device", as expected.

Alex Riesen

