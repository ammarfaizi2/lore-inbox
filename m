Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSBGMXg>; Thu, 7 Feb 2002 07:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSBGMXZ>; Thu, 7 Feb 2002 07:23:25 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:18126 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287532AbSBGMXJ>; Thu, 7 Feb 2002 07:23:09 -0500
Date: Thu, 7 Feb 2002 14:22:52 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Thomas Capricelli <tcaprice@logatique.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207122252.GL535637@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Thomas Capricelli <tcaprice@logatique.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020206162657.GD534915@niksula.cs.hut.fi> <4.3.2.7.2.20020206131121.00b1f670@mail.osagesoftware.com> <20020207075607.GE534915@niksula.cs.hut.fi> <20020207091001.2E36923CC4@persephone.dmz.logatique.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207091001.2E36923CC4@persephone.dmz.logatique.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:12:12AM +0100, you [Thomas Capricelli] wrote:
>  
> > Anyway, I think these kind of issues are solveable if only anybody agrees
> > this is a good idea...
> 
> 	I for sur agree. Especially if we consider the practical approach :
> 	Not all patches are required to add the file under linux/patches/,
> 	but good ones will
> 	Probability that such thing happen is almost 0, big kernel guys
> aren't even reading this thread :(. I won't loose my time trying ot make
> this happen as they wont even consider reading about such things.  too bad
> :(

Yes. The problem is that Linux/Alan/Marcelo or who ever maintains proper
kernel trees aren't interested - the /usr/src/linux/patches stuff is only on
the way for them. (Although they could easily rm -rf /usr/src/linux/patches
before making a release if they please.)

This idea is mostly applicable to external patches not ment for inclusion
(yet).

Maybe if there was a well-defined framework, we could persuade some of the
most influential patch maintainers (Rik van Riel, Robert Love, Andre Hedrick
etc..) use it. Then maybe, big maybe, it might catch fire.


-- v --

v@iki.fi
