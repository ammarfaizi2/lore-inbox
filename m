Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUHZHSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUHZHSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbUHZHSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:18:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:33450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267713AbUHZHSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:18:53 -0400
Date: Thu, 26 Aug 2004 00:18:06 -0700
From: Greg KH <greg@kroah.com>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040826071806.GA22646@kroah.com>
References: <1092793392.17286.75.camel@localhost> <200408250058.24845@smcc.demon.nl> <20040824230458.GA12422@kroah.com> <200408260058.59490@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408260058.59490@smcc.demon.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:58:59AM +0200, Nemosoft Unv. wrote:
> Hello,
> 
> On Wednesday 25 August 2004 01:04, Greg KH wrote:
> > On Wed, Aug 25, 2004 at 12:58:24AM +0200, Nemosoft Unv. wrote:
> > If you want to send me a patch to tell me to rip the whole driver out,
> > fine I will, no problems, I completly understand.
> 
> I don't think you do.

Just like I don't think you understand the laws involved here :)

> > But realize that anyone can then add it back, as the work you did was
> > released under the GPL :)
> 
> We'll see. Greg, please remove all references to the PWC driver from the 2.6 
> kernel ASAP. This also includes Documentation/usb/philips.txt and a 
> possible entry in the MAINTAINERS file. Sending a patch will probably be 
> pointless since you made changes I haven't seen.

I've done that.  You should send a patch to Pete to do the same for the
2.4 tree too.

I'm very sorry it's come to this, I really am.  

I'd like to personally thank you for all the time you've spent in
working on this driver over the years, and wish you the best in whatever
you do in the future.  Come back anytime.

thanks,

greg k-h
