Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269865AbRHIVf3>; Thu, 9 Aug 2001 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHIVfT>; Thu, 9 Aug 2001 17:35:19 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:28731 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S269865AbRHIVfN>; Thu, 9 Aug 2001 17:35:13 -0400
Date: Thu, 9 Aug 2001 17:34:59 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: arjan@fenrus.demon.nl
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: using bug reports on vendor kernels
Message-ID: <20010809173459.A24128@ead45>
In-Reply-To: <01080923020201.04501@idun> <m15Ux92-000PTaC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <m15Ux92-000PTaC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Thu, Aug 09, 2001 at 10:15:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 10:15:08PM +0100, arjan@fenrus.demon.nl wrote:
> In article <01080923020201.04501@idun> you wrote:
> 
> > is there a site that would allow me to browse a list of patches added to 
> > vendor kernels (esp. RedHat). I need this to use an oops supplied by a user.
> 
> I mostly documented the patches in the Red Hat Linux 7.1 default kernel
> (2.4.2-2) at
> 
> http://people.redhat.com/arjanv/patches.html
> 
> But as this was a fair amount of work which nobody seemed to want, I haven't
> actually finished nor done the same for later released kernels....
 
The real question is why not include the documentation with the patch?
As Linus will probably tell you, patch is pretty smart about stripping out stray
commentary, e.g.,

	patch -p1 < ~/mail/apply

Regards,

  Bill Rugolsky
