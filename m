Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUGaOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUGaOMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267956AbUGaOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:12:34 -0400
Received: from acp2.internetdsl.tpnet.pl ([83.16.67.2]:7064 "EHLO obarlan.pl")
	by vger.kernel.org with ESMTP id S267953AbUGaOMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:12:30 -0400
Date: Sat, 31 Jul 2004 16:22:23 +0200 (CEST)
From: tolekb@obarlan.pl
To: linux-kernel@vger.kernel.org
Subject: problem: device drivers
Message-ID: <Pine.LNX.4.58.0407311543120.5605@obarlan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

Few days ago I noticed problem with cd-rom control:
I put cd-rom damaged disc into cd-rom drive and I want to run it.
cd-rom (tried to start cd but he couldn't do this) and aplication 
stoped 
doing anything (not responding).
OK. I thought: umount the cd (I saw: device is busy)
OK. I thought: kill process (proces wasn't killed - I tried many time)
OK. I thought: I give up, I do shutdown (shutdown was hung on unmounting 
file system).

How can I fight with this (if it's possible).

I know: under windows I can take out cd - brutal force, but under 
linux I can't.

Some my frends have the same problem with floppy drive.

PS. Sorry for my poor english.

TolekB.
tolekb@obarlan.pl
