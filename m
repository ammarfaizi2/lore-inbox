Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVFWBqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVFWBqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVFWBoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:44:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261972AbVFWBnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:43:06 -0400
Date: Wed, 22 Jun 2005 18:45:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA0E0B.3080302@g-house.de>
Message-ID: <Pine.LNX.4.58.0506221829270.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA0E0B.3080302@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Christian Kujau wrote:
> 
> hm, isn't cogito doing this already?

Yes, but I want git to at least be usable stand-alone, and have example
scripts for the basics.

More specifically, I want to release a git-1.0, and I want to have a
tutorial that tells people how to use it so that they can get started
scripting (so that I can get out of that business again). I have the
beginnings of one, but quite frankly, last time I showed it to somebody it
became very clear that it may be intuitive when you already understand 
what git is doing, but if you're not interested in that, and just want a 
CVS replacement, it was just "strange".

So I want "raw git" to be good enough that I can write a tutorial, and 
people can pick it up. 

In contrast, what I think/hope the goals of cogito are is to have all the
nice color coding, the graphical commit tools, man-pages, etc. All the
things that made BK a pleasure to use (for example, I never used the BK
command line tools, I used the graphical "bk commit" thing. I know, I
know, I'm not a real man).

		Linus
