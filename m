Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311054AbSCHT03>; Fri, 8 Mar 2002 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311044AbSCHT0T>; Fri, 8 Mar 2002 14:26:19 -0500
Received: from stargazer.compendium-tech.com ([64.156.208.76]:25787 "EHLO
	stargazer.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S311056AbSCHT0N>; Fri, 8 Mar 2002 14:26:13 -0500
Date: Fri, 8 Mar 2002 11:25:33 -0800 (PST)
From: Kelsey Hudson <khudson@compendium-tech.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <20020308085028.A14375@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.44.0203081124580.20142-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Arjan van de Ven wrote:

> On Fri, Mar 08, 2002 at 09:35:35AM +0100, Martin Dalecki wrote:
> > Please look closer at my posting. I just think, that since there
> > are apparently no tru hardware raid devices out there it would
> > be sufficient to expand the detection code to not ignore
> > RAID class devices at all. This would just prevent
> > us from having two different entries in the
> > device detection list. Not much more involved I think.
> 
> There's one tiny glitch: there are exactly 2 "real" raid devices out there
> (that I know of at least). But anyway, a "don't look at" list will be
> MUCH shorter than a "look also at" list.

I know of two Promise cards that do hardware raid, and I know there are 
several cards available from 3Ware that also do hardware ata raid

 Kelsey Hudson                                           khudson@ctica.com 
 Associate Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     
==== 0100101101001001010000110100101100100000010010010101010000100001 =====


