Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWAEDmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWAEDmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWAEDmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:42:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:19845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751907AbWAEDmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:42:51 -0500
Date: Wed, 4 Jan 2006 19:42:13 -0800
From: Greg KH <greg@kroah.com>
To: gcoady@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: remove duplicate IDs
Message-ID: <20060105034213.GA23613@kroah.com>
References: <1isor19fmroc4ue21gnqkp6k1ln1pp06r1@4ax.com> <p5uor1lhum4ilra154o27e4vglvccd0v0a@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p5uor1lhum4ilra154o27e4vglvccd0v0a@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:40:12PM +1100, Grant Coady wrote:
> On Thu, 05 Jan 2006 12:14:16 +1100, Grant Coady <grant_lkml@dodo.com.au> wrote:
> 
> >
> >From: Grant Coady <gcoady@gmail.com>
> >
> >pci_ids.h: removes eight duplicate IDs that crept in during the 
> > 2.6.15 development cycle, commented a duplicate where one ID was 
> > defined in terms of another.  Compile tested with allyesconfig.
> >
> >Signed-off-by: Grant Coady <gcoady@gmail.com>
> 
> Sorry gang, please scratch.  I'll wait for -mm1

Why scratch, what was wrong?

I'd suggest working against Linus's git tree, that might be a bit
simpler than the -mm tree, and is what I merge against.

thanks,

greg k-h
