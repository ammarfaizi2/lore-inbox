Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRBYKo4>; Sun, 25 Feb 2001 05:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRBYKoq>; Sun, 25 Feb 2001 05:44:46 -0500
Received: from colorfullife.com ([216.156.138.34]:34830 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129563AbRBYKol>;
	Sun, 25 Feb 2001 05:44:41 -0500
Message-ID: <3A98E20F.3F8D023D@colorfullife.com>
Date: Sun, 25 Feb 2001 11:44:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] per-process namespaces for Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  * large cleanup of boot process (ramdisk handling, etc.)

Have you thought about supporting .tar.gz into ramfs? Creating custom
boot images would be simpler.

--
	Manfred
