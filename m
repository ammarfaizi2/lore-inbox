Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314087AbSEFEJo>; Mon, 6 May 2002 00:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSEFEJn>; Mon, 6 May 2002 00:09:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32180 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314087AbSEFEJm>;
	Mon, 6 May 2002 00:09:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15574.389.424221.379118@argo.ozlabs.ibm.com>
Date: Mon, 6 May 2002 14:07:33 +1000 (EST)
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020506004204.GJ2392@matchmail.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:

> On Sat, May 04, 2002 at 06:03:54PM +1000, Paul Mackerras wrote:
> > I still think that the time to build the global makefile is big enough
> > and obvious enough that many people (including myself) will want to
> > see it optimized, either by making the process itself more efficient
> > or by caching the result and re-using it where possible.
> 
> But it's still faster than kbuild-2.4.
> 
> This shouldn't keep it from going into mainline.  Just like anything else,
> the itch will be scratched if there's enough irritation, and inclusion of
> the new kbuild should at first *reduce* the irritation that's already there
> now.

Oh, I agree totally.  I'm just saying that I think there will be
enough irritation.  And this is a new irritation, which is for that
reason more noticeable than the old irritations which we are used to,
even if the old irritations are actually worse. :)

Paul.
