Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVI0JOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVI0JOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbVI0JOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:14:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:5267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964873AbVI0JOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:14:04 -0400
Date: Tue, 27 Sep 2005 01:36:30 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: cleanup: whitespace and remove unused entries
Message-ID: <20050927083630.GA26133@kroah.com>
References: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com> <20050926213557.GA21973@kroah.com> <1l0ij15ofhfsmhp3ijerg42uiv8v471jqr@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1l0ij15ofhfsmhp3ijerg42uiv8v471jqr@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:32:12PM +1000, Grant Coady wrote:
> On Mon, 26 Sep 2005 14:35:57 -0700, Greg KH <greg@kroah.com> wrote:
> >              We should start by removing the pci device and vendor ids
> >that are not currently used by the kernel, and then slowly move those
> >ids into the individual drivers, starting with the device ids, and maybe
> >eventually moving to the vendor ids.
> >
> >Sound ok?
> 
> Yep, I'll go find that script, bash it some more...  I'll leave the
> whitespace cleanup to last, since we gonna delete most of pci_ids.h?

Yes, that is the goal.

thanks,

greg k-h
