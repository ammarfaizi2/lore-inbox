Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRDHBGr>; Sat, 7 Apr 2001 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDHBG1>; Sat, 7 Apr 2001 21:06:27 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:21521 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S132151AbRDHBGS>; Sat, 7 Apr 2001 21:06:18 -0400
Date: Sun, 8 Apr 2001 11:05:36 +1000
From: CaT <cat@zip.com.au>
To: Dave Jones <davej@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
        bert@dutepp0.et.tudelft.nl, jeanpaul@dutepp0.et.tudelft.nl
Subject: Re: P-III Oddity.
Message-ID: <20010408110536.J632@zip.com.au>
In-Reply-To: <200104071933.VAA19651@cave.bitwizard.nl> <Pine.LNX.4.30.0104072149510.10936-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104072149510.10936-100000@Appserv.suse.de>; from davej@suse.de on Sat, Apr 07, 2001 at 09:56:40PM +0200
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2001 at 09:56:40PM +0200, Dave Jones wrote:
> On Sat, 7 Apr 2001, Rogier Wolff wrote:
> 
> > One machine regularly crashes.
> > Linux version 2.2.16-3 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Jun 19 19:11:44 EDT 2000
> 
> Probably unrelated to the issue below. Try a more recent 2.2 ?

2.2.19pre16 here. I don't have an SMP kernel but is this right:

cpuid level     : 3
Vendor ID: "GenuineIntel"; Max CPUID level 2

That line is the only line I could find that mentioned cpuid in your
code so I seem to be getting two different answers...

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

