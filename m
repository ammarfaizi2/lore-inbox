Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSEBWUh>; Thu, 2 May 2002 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314673AbSEBWUh>; Thu, 2 May 2002 18:20:37 -0400
Received: from www.transvirtual.com ([206.14.214.140]:3084 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314602AbSEBWUg>; Thu, 2 May 2002 18:20:36 -0400
Date: Thu, 2 May 2002 15:20:24 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: paulus@samba.org
cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        benh@kernel.crashing.org
Subject: Re: 2.5.11 framebuffer compilation error 
In-Reply-To: <15569.12507.794100.835854@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.10.10205021513040.11986-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> James Simmons writes:
> 
> > Diff:
> > 
> > http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff
> 
> I tried 2.5.12 with this patch on PPC, with most of the mac
> framebuffers selected, and got a few errors.  Here is a patch that
> fixes the compilation errors plus a few other things.

I applied your patch. Same place and I also applied to my BK tree. 
As for other changes. Alot of cleanups are going to happen. Soon you will
see with my new VESA framebuffer driver.

