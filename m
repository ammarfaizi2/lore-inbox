Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJYPUb>; Thu, 25 Oct 2001 11:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRJYPUU>; Thu, 25 Oct 2001 11:20:20 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:15118 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S274951AbRJYPUI>;
	Thu, 25 Oct 2001 11:20:08 -0400
Message-ID: <3BD82DC0.7697B1AF@nyc.rr.com>
Date: Thu, 25 Oct 2001 11:20:32 -0400
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Thu, Oct 25, 2001 at 10:31:08AM -0400, Frontgate Lab wrote:
> > Just out of a need to know things :)
> >
> > What compiler do Alan Cox and Linus use to create the 2.4 series
> > kernels?
> >
> > I am currently using RedHat's compiler gcc-2.96-85 and have been told
> > not to do so because it "breaks things" .
> 
> This is likely due to the fact that some people are still living with
> the misconception that all gcc-2.96 releases are buggy. They are not;
> only early versions are.
> 
> gcc-2.95.[34] and gcc-2.96-(newer versions) are viable choices if you
> want a working kernel. Some other versions might work, but then again,
> 
> At the moment, gcc3 doesn't work too well with the kernel, and you won't
> get any large benefit.
> 

I use gcc3 to compile anything and everything I need.  With the
exception of "multi-line literal complaints", my kernel compiles fine.

Is there anything that I should know?
