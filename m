Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTLXRNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTLXRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:13:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:3467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263711AbTLXRNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:13:50 -0500
Date: Wed, 24 Dec 2003 09:10:54 -0800
From: Greg KH <greg@kroah.com>
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ULMO@Q.NET, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up fs/devfs/base.c
Message-ID: <20031224171054.GB29796@kroah.com>
References: <20031224034110.GA25709@kroah.com> <Pine.LNX.4.33.0312241155170.3667-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0312241155170.3667-100000@wombat.indigo.net.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 12:00:13PM +0800, Ian Kent wrote:
> On Tue, 23 Dec 2003, Greg KH wrote:
> 
> > On Tue, Dec 23, 2003 at 06:38:20PM -0800, Andrew Morton wrote:
> > >
> > > Now would be a good time for someone to feed the whole thing through indent
> > > though.
> >
> > As much as I enjoy using the devfs code as my "bad coding style"
> > example, here's a patch against 2.6.0 that cleans up the devfs code to
> > follow the proper kernel coding style.
> 
> I think it needs a little bit more than that Greg.

Oh, I know it does.  That was just a "convert to proper coding format in
15 minutes" patch.  You should start with that and work from there.
But, if you are going to do this, remember to submit in incremental
changes.  I suggest this patch go in, as it is just a reformatting,
nothing else.  Then you can work from there, changing the actual logic
of the code.

thanks,

greg k-h
