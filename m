Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRLAAWt>; Fri, 30 Nov 2001 19:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283867AbRLAAWf>; Fri, 30 Nov 2001 19:22:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6161 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281214AbRLAAWU>;
	Fri, 30 Nov 2001 19:22:20 -0500
Date: Fri, 30 Nov 2001 22:22:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <3C07D669.6C234598@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L.0111302221180.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Jeff Garzik wrote:
> "Paul G. Allen" wrote:
> > IMEO, there is but one source as reference for coding style: A book by
> > the name of "Code Complete". (Sorry, I can't remember the author and I
> > no longer have a copy. Maybe my Brother will chime in here and fill in
> > the blanks since he still has his copy.)
>
> Hungarian notation???
>
> That was developed by programmers with apparently no skill to
> see/remember how a variable is defined.  IMHO in the Linux community
> it's widely considered one of the worst coding styles possible.

If your functions are so large that you need hungarian
notation to figure out the type of each variable, chances
are forgetting the variable type isn't the biggest of your
problems ;)

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

