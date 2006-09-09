Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWIIWCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWIIWCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWIIWCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:02:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:11739 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964896AbWIIWCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:02:50 -0400
Date: Sat, 9 Sep 2006 15:02:30 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "jens m. noedler" <noedler@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc6] [resend] Documentation/ABI: devfs is not obsolete, but removed!
Message-ID: <20060909220230.GA19539@suse.de>
References: <4502F7A9.70200@web.de> <45030245.9080005@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45030245.9080005@tls.msk.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 10:04:53PM +0400, Michael Tokarev wrote:
> jens m. noedler wrote:
> > Hi everybody, Greg, Linus,
> > 
> > This little patch just moves the devfs entry from ABI/obsolete to
> > ABI/removed and adds the comment, that devfs was removed in 2.6.18.
> > 
> []
> > +	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
> > +	along with the the assorted devfs function calls throughout the
> > +	kernel tree.
> 
> So, will the files be removed at some point, or has them been removed
> already? :)

They are already removed.

thanks,

greg k-h
