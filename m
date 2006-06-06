Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWFFVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFFVJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWFFVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:09:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11272 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751108AbWFFVJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:09:13 -0400
Date: Tue, 6 Jun 2006 21:06:19 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, John McCutchan <john@johnmccutchan.com>,
       Robert Love <rlove@rlove.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] inotify: split kernel API from userspace support
Message-ID: <20060606210619.GE4044@ucw.cz>
References: <20060601150702.GA2171@zk3.dec.com> <20060602123234.GA6586@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602123234.GA6586@zk3.dec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is a more descriptive changelog message for this patch:
> 
> This patch introduces a kernel API for inotify, making it possible for
> kernel modules to benefit from inotify's mechanism for watching
> inodes.

What are proposed uses of this API?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
