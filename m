Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136251AbRECIvw>; Thu, 3 May 2001 04:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136253AbRECIvm>; Thu, 3 May 2001 04:51:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:1031 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136251AbRECIvh>;
	Thu, 3 May 2001 04:51:37 -0400
Date: Thu, 3 May 2001 04:52:22 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg Banks <gnb@alphalink.com.au>
Cc: CML2 <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
Message-ID: <20010503045222.A28728@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg Banks <gnb@alphalink.com.au>,
	CML2 <linux-kernel@vger.kernel.org>
In-Reply-To: <20010503034755.A27693@thyrsus.com> <3AF11A0D.FB206A2B@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF11A0D.FB206A2B@alphalink.com.au>; from gnb@alphalink.com.au on Thu, May 03, 2001 at 06:42:53PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@alphalink.com.au>:
>   There is a natural order for presenting variables to the
> user, and that's the menu tree order.  At least in the Linux
> kernel CML2 corpus the menus are roughly organised from most
> general to most specific options, so options appearing earlier
> in the tree are likely to appear in more constraints and you
> probably want to ask the user to mutate them later.

OK.  Agreed, but it doesn't solve the general problem.  Generating
models is still hard.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To make inexpensive guns impossible to get is to say that you're
putting a money test on getting a gun.  It's racism in its worst form.
        -- Roy Innis, president of the Congress of Racial Equality (CORE), 1988
