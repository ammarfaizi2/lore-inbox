Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUHJAGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUHJAGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUHJAGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:06:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:58037 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267350AbUHJAGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:06:00 -0400
Date: Mon, 9 Aug 2004 17:05:40 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] hotplug resource limitation
Message-ID: <20040810000540.GB7131@kroah.com>
References: <411770DD.5080207@suse.de> <20040810000428.GA7131@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810000428.GA7131@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 05:04:28PM -0700, Greg KH wrote:
> > diff -pur linux-2.6.8-rc2-mm2/lib/kobject.c linux-2.6.8-rc2-mm2.hotplug/lib/kobject.c
> > --- linux-2.6.8-rc2-mm2/lib/kobject.c	2004-07-18 06:59:07.000000000 +0200
> > +++ linux-2.6.8-rc2-mm2.hotplug/lib/kobject.c	2004-08-05 15:12:18.000000000 +0200
> 
> <snip>  You really changed the kset_hotplug function, for no apparent
> reason.  Why?

Oops, nevermind, I see why now.  Sorry about that.

greg k-h
