Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSE0QjN>; Mon, 27 May 2002 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSE0QjM>; Mon, 27 May 2002 12:39:12 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:1016 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316677AbSE0QjL>; Mon, 27 May 2002 12:39:11 -0400
Date: Mon, 27 May 2002 12:39:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Matt Bernstein <matt@theBachChoir.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: VM oops in RH7.3 2.4.18-3
Message-ID: <20020527123912.A15560@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205271518270.5065-100000@nick.dcs.qmul.ac.uk> <m3lma54q53.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 10:33:12AM -0400, Jes Sorensen wrote:
> >>>>> "Matt" == Matt Bernstein <matt@theBachChoir.org.uk> writes:
> 
> Matt> This is a dual Athlon, 1 gig registered ECC DDR RAM, will try
> Matt> 2.4.18-4 but it doesn't look ext3-related (the only big local
> Matt> filesystem is reiserfs over s/w raid0).
> 
> Please send this to Red Hat before the kernel list. They are
> responsible for maintaining their kernel.

I'm sure Rik is interested in any feedback on the rmap patches that 
occur out in the wild...  even if they happen in vendor kernels.  With 
that said, we appreciate getting bugs like this filed in bugzilla.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
