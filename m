Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUKWEwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUKWEwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUKWEvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:51:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:43460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262196AbUKWEcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:32:22 -0500
Date: Mon, 22 Nov 2004 20:31:51 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tejun Heo <tj@home-tj.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc2 0/4] module sysfs: module sysfs related clean ups
Message-ID: <20041123043151.GA17580@kroah.com>
References: <20041123024537.GA7326@home-tj.org> <1101182308.4842.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101182308.4842.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 02:58:28PM +1100, Rusty Russell wrote:
> On Tue, 2004-11-23 at 11:45 +0900, Tejun Heo wrote:
> >  Hello,
> > 
> >  These are four patches to simplify/clean up implementation of module
> > sysfs stuff.
> 
> All look good to me.  Thanks!
> 
> Greg?

No objections from me either, look nice.  Want me to stage them in a bk
tree for inclusion in the -mm trees, so they get some coverage for a
while?

Or do you want to do that?

thanks,

greg k-h
