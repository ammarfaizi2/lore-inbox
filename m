Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293631AbSB1SGp>; Thu, 28 Feb 2002 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293693AbSB1SEB>; Thu, 28 Feb 2002 13:04:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32524 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293690AbSB1SBi>;
	Thu, 28 Feb 2002 13:01:38 -0500
Message-ID: <3C7E7083.169836E1@mandrakesoft.com>
Date: Thu, 28 Feb 2002 13:01:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Pavel Machek <pavel@ucw.cz>, Andries.Brouwer@cwi.nl,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl> <3C79435E.8030208@evision-ventures.com> <20020228094444.GB750@elf.ucw.cz> <3C7E3C71.6050604@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Pavel Machek wrote:
> > I run 2.4.x on 486sx, which is .... pretty close to 386. 386 support
> > is not going to get dropped anytime soon...

> Well the 486sx is the same die as 486 with coproc disabled. And in
> contrast the the 386 the 486 is a scalar, tough not super-scalar CPU.
> (This is what this "pipline stuff" and multiple pipeline stuff is about ;-).
> 
> Please trust me they are *not* very similar from CPU design point
> of view. They are only similar on the command set level.
> Anyway just to put it straight: Your system certainly won't be affected
> by the removal.

Regardless, 386 support should not go away...

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
