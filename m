Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVA2X2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVA2X2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVA2X2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:28:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:1726 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261596AbVA2X2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:28:20 -0500
Date: Sat, 29 Jan 2005 15:25:37 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement -
Message-ID: <20050129232537.GA14798@kroah.com>
References: <20050127090358.GC1528@kroah.com> <20050127165646.97935.qmail@web88003.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127165646.97935.qmail@web88003.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 11:56:46AM -0500, Shawn Starr wrote:
> Description: Cleanup some cluttered macros, add error
> checking for fan divisor value set.

Hm, we'll get there yet.  Your patch was not in a plain text form, so
that I could apply it directly from the email.

> Approved-by: Greg KH <greg@kroah.com>

I have not "approved it" yet at all.

> Signed-off-by: Sytse Wielinga
> <s.b.wielinga@student.utwente.nl>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

You have line wrap here too :(

>  --- Greg KH <greg@kroah.com> wrote: 
> > On Wed, Jan 26, 2005 at 12:31:30PM -0500, Shawn
> > Starr wrote:
> > > Here is the corrected fix, yeah that didn't make
> > > sense.   
> > > 3AM isn't a good time to send patches I guess :-)
> > 
> > Care to resend it, with a full description and a
> > Signed-off-by: line so
> > I can apply it?
> > 
> > thanks,
> > 
> > greg k-h
> >  

What's this "bottom post" stuff in here?

Also, please CC: the sensors mailing list so the developers there can
review the changes.

Can you try it again from scratch?

thanks,

greg k-h
