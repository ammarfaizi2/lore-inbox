Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWFVWjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWFVWjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWFVWjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:39:20 -0400
Received: from colin.muc.de ([193.149.48.1]:19975 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932660AbWFVWjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:39:20 -0400
Date: 23 Jun 2006 00:39:19 +0200
Date: Fri, 23 Jun 2006 00:39:19 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-ID: <20060622223919.GB50270@muc.de>
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622142430.3219f352.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 02:24:30PM -0700, Andrew Morton wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> >
> > As of last night, I still needed the Kconfig patch below to
> > successfully build allmodconfig on x86-64.  I believe Andrew has the
> > patch with a proper description and attribution, so I would prefer
> > that he send it...
> 
> It was transferred from the -mm-only stuff and into the x86_64 tree, so
> Andi owns it now.
> 
> I'll steal it back and will send it to Linus.

It's in my pile to eventually send, but so far nobody was able to explain
to me why it is suddenly needed at all, so  I wasn't feeling
very comfortable with it.

-Andi
