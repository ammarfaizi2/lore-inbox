Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbTC0Og3>; Thu, 27 Mar 2003 09:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262951AbTC0Og3>; Thu, 27 Mar 2003 09:36:29 -0500
Received: from [216.239.30.242] ([216.239.30.242]:31748 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP
	id <S262949AbTC0Og1>; Thu, 27 Mar 2003 09:36:27 -0500
Message-Id: <200303271447.h2RElSa1006173@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Thu, 27 Mar 2003 08:47:28 -0600
In-Reply-To: jlnance@unity.ncsu.edu
       "Re: Ptrace hole / Linux 2.2.25" (Mar 24, 10:33am)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 10:33am, jlnance@unity.ncsu.edu wrote:
} Subject: Re: Ptrace hole / Linux 2.2.25

Good morning to everyone.

> On Sun, Mar 23, 2003 at 08:44:23PM +0100, Martin Mares wrote:
> 
> > Do you really think that "People should either use vendor kernels or
> > read LKML and be able to gather the fixes from there themselves" is a
> > good strategy?

> Hi Martin,
>     I must say that I think it is an excellent strategy.  I will admit
> though, that I have voiced this opinion several times in the past and
> it seems that most people disagree with me.
>     I think we do a disservice to people by encouraging them to believe
> that the kernels they download from kernel.org can be depended on to
> work.  Kernel.org kernels are effectivly a way for people to participate
> in the development process and to help with QA.  If you dont want to
> be involved with these activities, you really do not want to use those
> kernels.
>     We could try and make that guarantee if we wanted to, but it would
> be a lot of work and the vendors are already doing it.  So why not
> leverage their work?

Let me state clearly that I don't have any problems with money being
made off free software.  I also understand the importance of Linux
vendors.

That being said the reason not to leverage their work is that the
reality of capitalism implies an imperative on the vendor to make
decisions which make 'their' kernel more appealing from a marketing
perspective.  Unfortunately the history of the software industry has
pretty effectively demonstrated that making software appealing from a
marketing perspective is at direct odds to producing a quality
product.

I personally have seen too many cases of vendor kernels exploding or
having problems in environments where I run stock statically compiled
kernels without problems.  That isn't meant as an indictment but an
observational fact.

I think the strategy of having a 'hot-list' of security or critical
performance patches for the current release kernel makes the most
amount of sense.  Those people that are comfortable with rolling their
own kernels can grab the patches and have at it.  The presence of
those patches shouldn't affect the steady progression of maintenance
on the 'stable' kernel.

> Jim

}-- End of excerpt from jlnance@unity.ncsu.edu

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Intel engineering seem to have misheard Intel marketing strategy.  The
phrase was 'Divide and conquer' not 'Divide and cock up'".
                                -- Alan Cox
