Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270596AbRHIVq7>; Thu, 9 Aug 2001 17:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270597AbRHIVqt>; Thu, 9 Aug 2001 17:46:49 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:45451 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S270596AbRHIVqg>;
	Thu, 9 Aug 2001 17:46:36 -0400
Date: Thu, 9 Aug 2001 22:46:35 +0100
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: using bug reports on vendor kernels
Message-ID: <20010809224635.A19529@fenrus.demon.nl>
In-Reply-To: <01080923020201.04501@idun> <m15Ux92-000PTaC@amadeus.home.nl> <20010809173459.A24128@ead45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010809173459.A24128@ead45>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 05:34:59PM -0400, Bill Rugolsky Jr. wrote:

> The real question is why not include the documentation with the patch?
> As Linus will probably tell you, patch is pretty smart about stripping out stray
> commentary, e.g.,
> 
> 	patch -p1 < ~/mail/apply
> 

Doesn't help the people who don't want to look at all the patches but just
want an overview.... and the spec file where the patches are applied does
have (mostly 1 liners) documentation.
