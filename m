Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCRAMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCRAMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVCRAMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:12:03 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:25047 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261390AbVCRAL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:11:57 -0500
Date: Thu, 17 Mar 2005 16:10:53 -0800
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BKCVS broken ?
Message-ID: <20050318001053.GA23358@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050317144522.GK22936@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317144522.GK22936@hottah.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got swamped, I'll look at this after dinner.  But you might take a look
at this: http://www.bitkeeper.com/press/2005-03-17.html which is a link
to a very simple open source BK client.  It doesn't do much except track
the head of the tree but it does that well.  It's slightly better than
that, it puts all the checkin comments in BK/ChangeLog so you don't have
to go over the wire to get those.

It's intended for someone who just wants the latest and greatest snapshot,
knows how to do cp -rp and diff -Nur, it's pretty basic.  It's not a
CVS gateway replacement but it does work for every tree on bkbits.net.
Just to be clear, we are not dropping the CVS gateway, this is "in
addition to" not "instead of".

If this turns out to be popular we can look at making a BitTorrent image
of each tree available so people can get at them without swamping us.

Don't worry about the license, it's a joke.  BSD license OK with everyone?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
