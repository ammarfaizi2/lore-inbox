Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVI2QQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVI2QQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVI2QQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:16:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:12465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932227AbVI2QQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:16:01 -0400
Date: Thu, 29 Sep 2005 09:14:51 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04a/04] pci_ids: whitespace cleanup, resend first half
Message-ID: <20050929161450.GC19770@kroah.com>
References: <vo0nj19p336vsm05mrtefan1fajgi6qngi@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vo0nj19p336vsm05mrtefan1fajgi6qngi@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:02:26PM +1000, Grant Coady wrote:
> 
> From: Grant Coady <gcoady@gmail.com>
> 
> pci_ids.h: whitespace cleanup, split into two 'cos lkml ate single patch.

This patch is going to be tough, as it will conflict with everything at
the same time (other trees that touch the file.)

I'll do this by hand, right before sending Linus a PCI git tree to
merge, if you don't mind.

> + *
> + *	September 2005 - cleanup by Grant Coady <gcoady@gmail.com>

changelog stuff within files is not needed, or encouraged at all.
That's why we have changelogs now.

thanks,

greg k-h
