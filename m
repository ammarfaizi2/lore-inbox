Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSE2Upt>; Wed, 29 May 2002 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSE2Upr>; Wed, 29 May 2002 16:45:47 -0400
Received: from www.transvirtual.com ([206.14.214.140]:60945 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315487AbSE2UoZ>; Wed, 29 May 2002 16:44:25 -0400
Date: Wed, 29 May 2002 13:44:12 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.5.19
In-Reply-To: <20020529211702.E30585@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is completely wrong - the driver has been tested NOT to work on
> the Integraphics 1682.  As such, please do uncomment these lines.

Due to a error with merging some stuff from a older DJ tree. I fixed it
in the fbdev BK repository.

> In addition, I'm disappointed that no one forwarded the patch for
> maintainer approval PRIOR to submitting it to Linus.

I'm even more disappointed that some people DONT test my patches especially
when I announce them and usually wait about 5 days before pushing them to 
Linus. Some of the changes I have done have been sitting around for months
in the DJ tree. The good news is that people can now look at skeletonfb.c
to see how to port the fbdev drivers to the new api. Of course I have a
feeling most will not bother so I will have to do it for them.


