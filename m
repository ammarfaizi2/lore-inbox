Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbREBJGH>; Wed, 2 May 2001 05:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbREBJF5>; Wed, 2 May 2001 05:05:57 -0400
Received: from pa147.bialystok.sdi.tpnet.pl ([213.25.59.147]:6148 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132465AbREBJFv>; Wed, 2 May 2001 05:05:51 -0400
Date: Wed, 2 May 2001 11:04:13 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@ulgo.koti.com.pl>
To: linux-kernel@vger.kernel.org
Subject: pci_fixup_via691_2 - again
Message-ID: <20010502110413.A661@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will it be possible to disable this fixup in kernel setup? I think, when VIA
MVP3 people will see, that 2.4.x is slower than 2.2.19, they just stay with
2.2.19, and if I understand correctly - 2.2.19 is unsafe like 2.4.4 with that
fixup disabled. I use this chipset for about year, never had any strange
filesystem crash. People who use Linux as a server system should enable any
security fixup, but if I use Linux as a workstation - I need fast video. And I
do backups.
