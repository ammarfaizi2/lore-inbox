Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290018AbSAWUOe>; Wed, 23 Jan 2002 15:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290020AbSAWUOY>; Wed, 23 Jan 2002 15:14:24 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:8130 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290018AbSAWUON>; Wed, 23 Jan 2002 15:14:13 -0500
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][PATCH] accessfs v0.3
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 23 Jan 2002 21:12:19 +0100
Message-ID: <87lmeosu70.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following Changes are in the new version of accessfs:

- default mount point /proc/access (Ben Clifford)
- Documentation/Configure.help cleanup (Ben Clifford)
- ipv4 raw socket support (used by e.g. ping, traceroute)

The patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.4.14-0.3.patch.gz>
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.4.17-0.3.patch.gz>
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.5.2-0.3.patch.gz>

I didn't test 2.4.17 and 2.5.2.

Regards, Olaf.
