Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265662AbSKAIWu>; Fri, 1 Nov 2002 03:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265664AbSKAIWt>; Fri, 1 Nov 2002 03:22:49 -0500
Received: from cih-gw.cih.com ([204.69.206.1]:29643 "HELO cih.com")
	by vger.kernel.org with SMTP id <S265662AbSKAIWS>;
	Fri, 1 Nov 2002 03:22:18 -0500
Date: Fri, 1 Nov 2002 00:23:28 -0800 (PST)
From: "Craig I. Hagan" <hagan@cih.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bill Davidsen <davidsen@tmr.com>, "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210312233190.5595-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211010013490.3873-100000@svr.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Talk is cheap.
> 
> I've not seen a _single_ bug-report with a fix that attributed the
> existing LKCD patches. I might be more impressed if I had. 
> 
> The basic issue is that we don't put patches in in the hope that they will
> prove themselves later. Your argument is fundamentally flawed.

comment from userspace:

I'm going to have to side with Linus here despite my desire to see LKCD merged.
However, we need to show him the money. This means:

	* making sure that the patches are kept up to date

	* keep the LKCD patches in the list/community spotlight in a positive
		manner ("please test this!", or  "please use this when
		looking for help debugging a system problem"). Perhaps
		a 2.5.x-lkcd bk tree or something like that.

	* make documentation/HOWTO's available for folks so that
		they'll know how to generate a crashdump
		and run a some utilities against it to generate
		a synopsis which can be submitted for debugging

	* most important: squash a whole lot of bugs with
		said dumps!

If it becomes apparent through empirical data that crash dumps are a useful
tool, I'm sure that Linus will become far more amenable. Until then, lets let
him handle all of his other work which needs to get done.

-- craig



	  .-    ... . -.-. .-. . -    -- . ... ... .- --. .

			    Craig I. Hagan
			   hagan(at)cih.com



