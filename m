Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVCJQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVCJQuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVCJQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:50:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:32671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262745AbVCJQtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:49:01 -0500
Date: Thu, 10 Mar 2005 08:43:12 -0800
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050310164312.GC16126@kroah.com>
References: <20050309072833.GA18878@kroah.com> <16944.6867.858907.990990@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16944.6867.858907.990990@cse.unsw.edu.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 09:00:51PM +1100, Neil Brown wrote:
> On Tuesday March 8, greg@kroah.com wrote:
> > So here's a first cut at how this 2.6 -stable release process is going
> > to work that Chris and I have come up with.  Does anyone have any
> > problems/issues/questions with this?
> 
> One rule that I thought would make sense, but that I don't see listed
> is:
> 
>  - must fix a regression

That, and a zillion other specific wordings that people suggested fall
under the:
	or some "oh, that's not good" issue
rule.

I didn't feel like being all lawyer-like and explicitly spelling out all
of the different kinds of bugs that we would be accepting patches for :)

So yes, I don't have a problem with patches to fix regressions.

thanks,

greg k-h
