Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285453AbRLNS5X>; Fri, 14 Dec 2001 13:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285457AbRLNS5O>; Fri, 14 Dec 2001 13:57:14 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:23560 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285453AbRLNS5A>; Fri, 14 Dec 2001 13:57:00 -0500
Date: Fri, 14 Dec 2001 10:59:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Balanced Multi Queue Scheduler ...
Message-ID: <Pine.LNX.4.40.0112141052420.975-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, after a lot of talking here's the second version of the Balanced
Multi Queue Scheduler :

http://www.xmailserver.org/linux-patches/mss-2.html

The patch is described inside the link that contains tests on UP and 2
way SMP systems.
The latency is dramatically improved even if my first focus has been the
balancing code.
As soon as OSDLAB will grant me access on 8 way ( and 16 way ) SMP
machines more tests will follow.




- Davide


