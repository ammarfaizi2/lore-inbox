Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUBOWFC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBOWFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:05:02 -0500
Received: from mail.riseup.net ([216.162.217.191]:20715 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S265217AbUBOWFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:05:00 -0500
Date: Sun, 15 Feb 2004 16:04:54 -0600
From: Micah Anderson <micah@riseup.net>
To: linux-kernel@vger.kernel.org
Subject: stable/vanilla+(O)1
Message-ID: <20040215220454.GL14140@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a patch to the stable/vanilla 2.4 kernel tree which provides
the O(1) scheduler code from 2.6? The closest thing I can find is:

http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0

which is for AC (and is also A0), is there a newer 2.4.23/24 patch
that works against stock? The above patch fails miserably against a
stock 2.4.22 kernel.

There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/ 
the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
fails horribly on a stock 2.4.22.

I've been crawling through list archives, but have yet to find
anything, so I am reduced to asking. :)

micah
