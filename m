Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUBKPXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBKPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:23:54 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:8682 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265768AbUBKPXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:23:51 -0500
Date: Wed, 11 Feb 2004 07:23:49 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200402111523.i1BFNnOq020225@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: reiserfs for bkbits.net?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're moving openlogging back to our offices and I'm experimenting with 
filesystems to see what gives the best performance for BK usage.  Reiserfs
looks pretty good and I'm wondering if anyone knows any reasons that we
shouldn't use it for bkbits.net.  Also, would it help if the journal was
on a different disk?  Most of the bkbits traffic is read so I doubt it.

Please cc me, I'm not on the list.
