Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWEaUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWEaUaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWEaUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:30:11 -0400
Received: from mail.linicks.net ([217.204.244.146]:41927 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751404AbWEaUaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:30:10 -0400
From: Nick Warne <nick@linicks.net>
To: Antonio <tritemio@gmail.com>
Subject: Re: [radeonfb]: unclean backward scrolling
Date: Wed, 31 May 2006 21:29:49 +0100
User-Agent: KMail/1.9.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Ondrej Zary" <linux@rainbow-software.org>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com> <20060526174054.GA3361@ucw.cz> <5486cca80605290109v368057b8m9141ec18586773d3@mail.gmail.com>
In-Reply-To: <5486cca80605290109v368057b8m9141ec18586773d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605312129.49309.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 09:09, Antonio wrote:
> > > I have probably the same problem - but with vesafb on my
> > > notebook (800x600). When I scroll back/forward or run mc
> > > and then exit, it fixes itself. The problem was probably
> > > always there (in 2.6.x - don't know about older
> > > versions).
> >
> > I see it too, and it is as old as framebuffer support iirc.
>
> Have you tried the patch early posted by Antonino A. Daplas?
>
> For me and Nik Warne it fixes the problem.
>
> I hope the patch is queued for inclusion...
>
> Cheers,
>
>   ~ Antonio

Yes it will be fixed... don't panic.

I am also jumping the wagon here - for some reason any mail I send to lkml 
disappears now (so a test too)...

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
