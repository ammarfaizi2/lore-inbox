Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVI3As3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVI3As3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVI3As2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:48:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932506AbVI3AsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:48:23 -0400
Date: Thu, 29 Sep 2005 17:47:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Dave Jones <davej@redhat.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated 
In-Reply-To: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org>
References: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Horst von Brand wrote:
> 
> Can I get a URL for the source for your editor? The one on kernel.org
> doesn't compile, and probably hasn't for a long time.

Oh, it compiles with trivial modifications. Not cleanly, but it works.

I put my git repo on 

	kernel.org:/pub/software/editors/uemacs/uemacs.git

but it will take a moment to mirror out. 

The "readme" says non-commercial only, but I asked Daniel Lawrence if it 
was ok to include it in commercial distributions a long time ago, and he 
said yes. Sadly, I've lost that email, so I don't have any paper trail for 
that. So you should consider the readme binding.

> [Yes, there is some (perverse) fun in telling people you use the very same
>  editor than Linus Torvalds :-]> 

The thing is, it's not a wonderful editor. It's small, and good enough, 
but I really wished somebody wrote something that handled UTF-8, for 
example.  But I've got the keybindings hardcoded in my spine, so I can't 
ever change.

		Linus
