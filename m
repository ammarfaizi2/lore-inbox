Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWADXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWADXPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWADXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:15:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:16537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751824AbWADXO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:14:59 -0500
Date: Wed, 4 Jan 2006 15:12:30 -0800
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Nick Warne <nick@linicks.net>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104231226.GC14788@kroah.com>
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk> <20060104220157.GB12778@kroah.com> <200601042249.12116.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042249.12116.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:49:11PM +0000, Alistair John Strachan wrote:
> Re-read the thread. The confusion here is about "going back" to 2.6.14 before 
> patching 2.6.15. This has nothing to do with "rc kernels". We have this 
> documented explicitly in the kernel but not on the kernel.org FAQ.

The kernel.org FAQ does not deal with Linux kernel specific things, only
kernel.org specific things.  So documenting it in the kernel itself is
the proper place for it :)

thanks,

greg k-h
