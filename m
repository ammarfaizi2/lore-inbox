Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280806AbRKGPBP>; Wed, 7 Nov 2001 10:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280808AbRKGPBF>; Wed, 7 Nov 2001 10:01:05 -0500
Received: from mustard.heime.net ([194.234.65.222]:46783 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280806AbRKGPA4>; Wed, 7 Nov 2001 10:00:56 -0500
Date: Wed, 7 Nov 2001 16:00:55 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: ext3 vs resiserfs vs xfs
Message-ID: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

What's coolest/best/worst of ext3, ReiserFS and XFS?
I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
I see no difference at all. After a chrash, it really wants to run fsck
anyway. I've tried ReiserFS before, with no fsck after chrashes - is this
because ReiserFS is better, or is it more like a hope-it's-ok-thinkig?
Then - last - How about XFS?

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

