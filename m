Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288166AbSACDcb>; Wed, 2 Jan 2002 22:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288168AbSACDcV>; Wed, 2 Jan 2002 22:32:21 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:6021
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288166AbSACDcQ>; Wed, 2 Jan 2002 22:32:16 -0500
Date: Wed, 2 Jan 2002 22:18:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102221845.A27252@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de>; from davej@suse.de on Thu, Jan 03, 2002 at 04:26:40AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> Go down the DMI path, and get it right _sometimes_, or take a zero.
> Getting it right sometimes is likely to do more harm than good.

Not in this case.  If the DMI read fails, the worst-case result is the
user sees some ISA extra questions.
 
> Crap. I'm implying that there should be a learning curve to everything
> no matter how small it may be. You're trying to remove the curve
> altogether.

Damn straight.  Not that I think that's necessarily 100% achievable, but 
it's the right way to aim.
 
> And write a book perchance ? SCNR  8-)

It's happened before... :-)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No kingdom can be secured otherwise than by arming the people.  The possession
of arms is the distinction between a freeman and a slave. 
        -- "Political Disquisitions", a British republican tract of 1774-1775
