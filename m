Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUEBGi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUEBGi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUEBGi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:38:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:3732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261500AbUEBGiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:38:24 -0400
Date: Sat, 1 May 2004 23:29:47 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       tim@cyberelk.net
Subject: Re: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040502062944.GA3766@kroah.com>
References: <20040410135115.GA3612@penguin.localdomain> <20040410170148.GI1317@kroah.com> <20040410180636.GB3612@penguin.localdomain> <20040410194601.GC3612@penguin.localdomain> <20040410202858.GU31500@parcelfarce.linux.theplanet.co.uk> <20040411082553.GA2499@penguin.localdomain> <20040412185121.GD21502@kroah.com> <20040413172924.GA2466@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413172924.GA2466@penguin.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 07:29:24PM +0200, Marcel Sebek wrote:
> On Mon, Apr 12, 2004 at 11:51:21AM -0700, Greg KH wrote:
> > On Sun, Apr 11, 2004 at 10:25:53AM +0200, Marcel Sebek wrote:
> > Looks much better, thanks.  But please don't modify the current devfs
> > usage, those users will generally not like that.  Can you redo this
> > patch to only add the sysfs changes?
> > 

Looks good, applied, thanks.

greg k-h
