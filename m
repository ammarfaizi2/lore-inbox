Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSFXOkW>; Mon, 24 Jun 2002 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSFXOkV>; Mon, 24 Jun 2002 10:40:21 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:39296 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313628AbSFXOkU>;
	Mon, 24 Jun 2002 10:40:20 -0400
Date: Mon, 24 Jun 2002 04:09:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
Message-ID: <20020624020910.GB136@elf.ucw.cz>
References: <1024079726.29929.131.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024079726.29929.131.camel@cog>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hey Marcelo,
> 	I know its probably poor form to send this out so close to -rc, but I
> figured I might as well give it a shot. I'll happily resubmit this for
> the .20pre series later if you'd prefer.

Why so gly #ifdefs? We can disable it runtime already, you should need
just *one* ifdef.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
