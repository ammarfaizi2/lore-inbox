Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTKSBn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 20:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbTKSBn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 20:43:57 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:4742 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263766AbTKSBn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 20:43:56 -0500
Date: Tue, 18 Nov 2003 17:43:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, lm@elf.ucw.cz
Subject: Re: bkcvs at rsync.kernel.org not up-to-date?
Message-ID: <20031119014352.GA9375@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, lm@elf.ucw.cz
References: <20031118230352.GA2152@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118230352.GA2152@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 12:03:52AM +0100, Pavel Machek wrote:
> Web interface indicates last change 22 hours ago, yet rsync indicates
> nothing new. I know that bkcvs was supposed to be down over weekend,
> but I thought it should be up by now?

It's still down.  The machine got moved from one colo to another and when 
we went down there to find it it was nowhere to be found.  So they are 
tracking it down and we'll try and get it up tomorrow.

I've offered to update the rsync tree on kernel.org directly if HPA figures
out how to turn on my account (something I've been waiting on for at least
a year, hint, hint).
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
