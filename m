Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbTCZUKB>; Wed, 26 Mar 2003 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbTCZUKB>; Wed, 26 Mar 2003 15:10:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262174AbTCZUJx>;
	Wed, 26 Mar 2003 15:09:53 -0500
Date: Thu, 27 Mar 2003 08:47:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       James Bourne <jbourne@hardrock.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030327074727.GA3021@zaurus.ucw.cz>
References: <3E7E4C63.908@gmx.de> <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org> <20030324003946.GA11081@wohnheim.fh-wedel.de> <3E7E736D.4020200@zytor.com> <20030324144219.GC29637@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324144219.GC29637@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > >maybe. Peter, what do you think?
>  > I'd rather keep the collection itself on kernel.org.
> 
> Another possibility just occured to me.
> It'd be useful to add a feature that adds a check to the
> build process..
> 
> "Download post-release errata ? [Y/n]"
> 
> and have it wget patches from k.o, verify signatures and auto-apply them,
> which removes the "admin didnt even know there were patches
> that needed to be applied" possibility.
> 

That looks like ugly can of worms to me.
"what kernel do you have?"
"2.4.25 and it did two downloads; I was
compiling it on the friday night"

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

