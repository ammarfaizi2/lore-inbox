Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVI1Jhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVI1Jhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVI1Jhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:37:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:2696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030234AbVI1Jhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:37:33 -0400
Date: Wed, 28 Sep 2005 02:36:33 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand fixes for 2.6.14
Message-ID: <20050928093633.GA12757@kroah.com>
References: <524q85on6e.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524q85on6e.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 09:01:45PM -0700, Roland Dreier wrote:
> Linus, please pull from
> 
>     master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

Hm, I complained about this last time, with no response...

I didn't think that git pulls were going to be allowed from subsystem
maintainers after -rc1 came out.  After that, patches by email were
required to be sent, not git pulls.  This does cause a bit more work
for the maintainer, but it ensures that they only send the patches they
really want to get in.

At least that was what I thought we decided on at the kernel summit...

thanks,

greg k-h
