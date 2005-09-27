Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVI0MdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVI0MdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVI0MdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:33:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:60899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964826AbVI0MdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:33:07 -0400
Date: Tue, 27 Sep 2005 05:31:16 -0700
From: Greg KH <greg@kroah.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: remove duplicated and non-referenced symbols
Message-ID: <20050927123116.GA10188@kroah.com>
References: <f39ij1pe755t19dpgn5teed8e7069u3fmf@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39ij1pe755t19dpgn5teed8e7069u3fmf@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 09:01:34PM +1000, Grant Coady wrote:
> Hi Greg, All,
> 
> Attached is first patch to cleanup pci_ids.h, compressed as it is 68k 
> straight text.  More patches to follow moving device IDs to where they 
> be referenced.  Whitespace cleanup planned at end of patch series.
> 

Please don't compress the patch, it's a pain to apply, I can handle
large emails.  Or split it up into multiple patches if lkml can't handle
it.

thanks,

greg k-h
