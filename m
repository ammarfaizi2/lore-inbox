Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270597AbRHIV4D>; Thu, 9 Aug 2001 17:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270599AbRHIVzz>; Thu, 9 Aug 2001 17:55:55 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:58428 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S270597AbRHIVzm>; Thu, 9 Aug 2001 17:55:42 -0400
Date: Thu, 9 Aug 2001 17:55:36 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: using bug reports on vendor kernels
Message-ID: <20010809175536.B22594@ead45>
In-Reply-To: <01080923020201.04501@idun> <m15Ux92-000PTaC@amadeus.home.nl> <20010809173459.A24128@ead45> <20010809224635.A19529@fenrus.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010809224635.A19529@fenrus.demon.nl>; from arjan@fenrus.demon.nl on Thu, Aug 09, 2001 at 10:46:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 10:46:35PM +0100, Arjan van de Ven wrote:
> On Thu, Aug 09, 2001 at 05:34:59PM -0400, Bill Rugolsky Jr. wrote:
> 
> > The real question is why not include the documentation with the patch?
> > As Linus will probably tell you, patch is pretty smart about stripping out stray
> > commentary, e.g.,
> > 
> > 	patch -p1 < ~/mail/apply
> > 
> 
> Doesn't help the people who don't want to look at all the patches but just
> want an overview.... and the spec file where the patches are applied does
> have (mostly 1 liners) documentation.

Well, my point is that the person creating the patch or adding it to the kernel
should document it, thereby distributing the work.  If formatted as a standard
header, one could pull it all out with a favorite text processing tool,
sed ... perl, and put it in a file, in say
/usr/share/doc/kernel*/rh-patch-descriptions. :-)

Regards,

   Bill Rugolsky

