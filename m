Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269780AbUJMSpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269780AbUJMSpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269781AbUJMSpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:45:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:33735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269780AbUJMSps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:45:48 -0400
Date: Wed, 13 Oct 2004 10:41:06 -0700
From: Greg KH <greg@kroah.com>
To: leif <leif@gci.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: patch: usb serial driver pl2303
Message-ID: <20041013174106.GA17291@kroah.com>
References: <0I5H00HK0OSMXZ@mmp-2.gci.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0I5H00HK0OSMXZ@mmp-2.gci.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 12:55:28PM -0800, leif wrote:
> > From: leif [mailto:leif@gci.net] 
> > Just a small patch to add support for the Microsoft branded 
> > Pharos GPS-360.
> > 
> > The device uses the same driver, just requires the additional 
> > product_id of 0xaaa0
> > 
> > 
> > Please reply directly, as I'm not subscribed.
> > 
> 
> eh.  My bad... That diff was a little screwy.
> 
> This one's been tested.
> 
> It's been a long day. :-)

Hm, I don't see your patch...

> begin 666 pl2303.diff
> M9&EF9B M<G4@;&YX,C8Y<#0M;VQD+V1R:79E<G,O=7-B+W-E<FEA;"]P;#(S

Heh, uuencode.  Hm, care to read Documentation/SubmittingPatches and try
it again?  Also be sure to CC: the maintainer of the driver you are
patching, and please note the kernel tree that you are patching against.

thanks,

greg k-h
