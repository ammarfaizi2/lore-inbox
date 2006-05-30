Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWE3NwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWE3NwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWE3NwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:52:00 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:41618 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751503AbWE3Nv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:51:59 -0400
Date: Tue, 30 May 2006 09:51:58 -0400
From: Amy Griffis <amy@griffis1.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john@johnmccutchan.com, rlove@rlove.org
Subject: Re: [PATCH] inotify kernel API
Message-ID: <20060530135158.GA24918@zk3.dec.com>
References: <20060526021030.GA4936@zk3.dec.com> <20060530024013.5d80ba81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530024013.5d80ba81.akpm@osdl.org>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 02:40:13AM -0700, Andrew Morton wrote:
> On Thu, 25 May 2006 22:10:30 -0400
> Amy Griffis <amy.griffis@hp.com> wrote:
> 
> >  fs/inotify.c                          |  991 +++++++++-------------------------
> >  fs/inotify_user.c                     |  719 ++++++++++++++++++++++++
> 
> This patch would be much easier to review if the move-code-around part was
> delivered in a separate patch from the add-new-functionality part.

Makes sense.  I'll split it up and repost.
