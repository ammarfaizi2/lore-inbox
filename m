Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbULPTBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbULPTBC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULPTBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:01:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:17339 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261988AbULPS5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:57:48 -0500
Date: Thu, 16 Dec 2004 10:57:36 -0800
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041216185524.GA5654@kroah.com>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <200410272012.44361.dtor_core@ameritech.net> <20041029205505.GB30638@kroah.com> <200410301644.33997.cova@ferrara.linux.it> <20041101223153.GB17341@kroah.com> <20041216095023.X469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216095023.X469@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 09:50:23AM -0800, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > I have been recently advised that I should not change these symbols, and
> > so I will not.
> 
> This is still in -mm, is that intentional or just a minor oversight?

It's an oversight due to the way Andrew pulls from my trees.  I posted
about this earlier this week as to how to fix this (Andrew, just delete
your local copy of my driver bk tree, and reclone it.  That will fix
it.)

thanks,

greg k-h
