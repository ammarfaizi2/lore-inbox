Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270405AbRHWVO1>; Thu, 23 Aug 2001 17:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270460AbRHWVOS>; Thu, 23 Aug 2001 17:14:18 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:32139
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270405AbRHWVOH>; Thu, 23 Aug 2001 17:14:07 -0400
Date: Thu, 23 Aug 2001 14:14:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823141417.C14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1X2-000LOp-00@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15a1X2-000LOp-00@f10.mail.ru>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 12:56:52AM +0400, Samium Gromoff wrote:
> > Because with the exception of your unique situation in which you have
> > a machine which is stable enough to compile a kernel on and develop
> > but can't run python, it's not a problem.
> 
>    Tom, i think Jes wanted to tell that basically
>  there _are_ the cases when python hurts, so
>  losing the freedom not to install python is not
>  good. 

What I'm saying is that the cases where you somehow don't have the room
to toss in a stripped down python, but do have room for gcc and the
kernel sources + compiling them are freakishly rare, if they do exist.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
