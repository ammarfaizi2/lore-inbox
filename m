Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTL3AeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTL3AeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:34:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:36331 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261659AbTL3AeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:34:19 -0500
Date: Mon, 29 Dec 2003 16:32:47 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, mgorse@mgorse.dhs.org,
       linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
Message-ID: <20031230003246.GB16187@kroah.com>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com> <20031208224810.GB31134@kroah.com> <200312281538.42309.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312281538.42309.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 03:38:42PM +0300, Andrey Borzenkov wrote:
> On Tuesday 09 December 2003 01:48, Greg KH wrote:
> > Ok, I'm ccing lkml and everyone else who has been in on this thread at
> > different times.  This is based on a patch from Andrey that was/is in
> > the -mm tree for a while.
> >
> 
> what about second part in sysfs/dir.c? How relevant is it?

Very relevant, that's why it's in the -mm tree right now :)

thanks,

greg k-h
