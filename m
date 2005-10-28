Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbVJ1WY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbVJ1WY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbVJ1WY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:24:29 -0400
Received: from [139.30.44.2] ([139.30.44.2]:47876 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751897AbVJ1WY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:24:28 -0400
Date: Sat, 29 Oct 2005 00:24:27 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Kyle McMartin <kyle@parisc-linux.org>
Subject: ominous git commit
Message-ID: <Pine.LNX.4.61.0510290017460.20152@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to admit I don't understand much about git, but this monster 
merge somehow worries me:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=210cc679faf0e1cabda9fc5d1279644f5e52aecb

It's commit message says: 'Auto-update from upstream', and it indeed seems 
to contain changes already made to the upstream tree. Would someone please 
explain to me why it shows up in Linus' tree?

Thanks,
Tim
