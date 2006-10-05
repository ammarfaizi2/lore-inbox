Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWJEUlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWJEUlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWJEUlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:41:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:41962 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932082AbWJEUlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:41:19 -0400
Date: Thu, 5 Oct 2006 13:34:24 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061005203424.GA16932@kroah.com>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <20061005124601.94ed7194.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005124601.94ed7194.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 12:46:01PM -0700, Andrew Morton wrote:
> A quick survey of the wreckage:
> 
> - five of Greg's USB patches need fixing

I'll fix my stuff up, no objection from me at all, push it in :)

thanks,

greg k-h
