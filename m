Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVAZQqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVAZQqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVAZQor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:44:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:3815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262351AbVAZQnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:43:04 -0500
Date: Wed, 26 Jan 2005 08:40:10 -0800
From: Greg KH <greg@kroah.com>
To: Mikkel Krautz <krautz@gmail.com>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org, jb@technologeek.org
Subject: Re: [PATCH 0/3] TIGLUSB Cleanups
Message-ID: <20050126164010.GB3274@kroah.com>
References: <41F7BF8D.70205@gmail.com> <d4b385205012608272e300b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b385205012608272e300b1b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 05:27:46PM +0100, Mikkel Krautz wrote:
> On Wed, 26 Jan 2005 17:04:29 +0100, Mikkel Krautz <krautz@gmail.com> wrote:
> > Hello!
> > 
> > The tiglusb-driver was removed in 2.6.11-rc1.
> > 
> > Since then, references to it in other files have been kept, namely the
> > following files:
> > 
> >     Documentation/usb/silverlink.txt,
> >     Documentation/kernel-parameters.txt
> >     MAINTAINERS
> > 
> > This series of patches removes the silverlink.txt-documentation, and
> > tiglusb-references in MAINTAINERS and kernel-parameters.txt.
> > 
> > The patches are diffed against 2.6.11-rc2-bk4.
> > 
> > Thanks,
> > Mikkel Krautz
> > 
> 
> Hurrah!
> 
> All the patches were word-wrapped by Thunderbird, even though I disabled it.
> 
> I'm sorry, but this is all I can do for now. Sigh.

Use a different email client, or attach the patches as plain text.

Good luck,

greg k-h
