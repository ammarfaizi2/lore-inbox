Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286466AbRL0SjI>; Thu, 27 Dec 2001 13:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286455AbRL0Si7>; Thu, 27 Dec 2001 13:38:59 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:40210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286468AbRL0Siv>; Thu, 27 Dec 2001 13:38:51 -0500
Date: Thu, 27 Dec 2001 18:38:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227183839.C19618@flint.arm.linux.org.uk>
In-Reply-To: <200112271738.fBRHcSd30844@vindaloo.ras.ucalgary.ca> <E16JerY-0006Jm-00@the-village.bc.nu> <200112271759.fBRHxtH31437@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112271759.fBRHxtH31437@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Thu, Dec 27, 2001 at 10:59:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 10:59:55AM -0700, Richard Gooch wrote:
> Oh, don't get me wrong. I agree completely. A short two minute reply
> is not that much to ask for, and I wish Linus would be more
> responsive.

Lets give a good instance of where a "two minute reply" doesn't work.

Patch 816/1:
  http://www.arm.linux.org.uk/developer/patches/?action=viewpatch&id=816/1

Patch received - 30 November.  Comment made - 13 December.  Reply - 13th
December - "Could you be more detailed on these points".

Well, the comment that's there was written over a couple of hours or more.
Why?  Because it had interdependencies on a number of other patches to see
what was going on behind some of the indirections and so forth.  That mail
hasn't had a reply yet is:

 - its buried behind 200 other messages, so its out of sight.
 - it would require me to stop and think about it for significantly
   longer to work out what this patch and the other patches were
   trying to do.

Oh, don't get me wrong - I'm not about to give up my patch system!  It
does serve some very important purposes in making my life easier:

- not loosing patches I want to apply under a mountain of email.
- lets other people find patches that might be useful, but weren't
  applied, and see the feedback on the patch.

I'd encourage anyone who wants to follow up this email to go and look
at the patches in question first - probably the easiest way is to go to:

  http://www.home.arm.linux.org.uk/developer/patches/

type 'ipaq' into the "search for patch summaries containing" box and hit
enter.  Note that most of the ipaq patches remaining depend on 816/1.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

