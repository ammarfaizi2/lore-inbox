Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270521AbRHWVe5>; Thu, 23 Aug 2001 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbRHWVes>; Thu, 23 Aug 2001 17:34:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:40331
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270521AbRHWVeb>; Thu, 23 Aug 2001 17:34:31 -0400
Date: Thu, 23 Aug 2001 14:34:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 01:18:02AM +0400, Samium Gromoff wrote:
> > And if you're trying to do this on the machine you're trying to make
> > supported, you're going to have lots of fun.
>
>   so you like python. okay.

Actually, I only know a bit of python.  It seems nice but I've been
caught up doing real work (and learning PPC asm at the same time.)

>   but imagine the X arch hacker does not like python,
> and nevertheless needs to port it on arch X.
>   still fun?

Well I know python is endian-clean.  I'd suspect it's even 32/64bit clean.
So it's not a matter of 'port' but compile.  And Linus has done things which
have made lots of kernel hackers scratch their head for a while.  (Jump
out of this fire and into the min/max macros in 2.4.9 fire to see
what I mean).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
