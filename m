Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSB0ITI>; Wed, 27 Feb 2002 03:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292234AbSB0IS6>; Wed, 27 Feb 2002 03:18:58 -0500
Received: from gate.perex.cz ([194.212.165.105]:41743 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S292233AbSB0ISx>;
	Wed, 27 Feb 2002 03:18:53 -0500
Date: Wed, 27 Feb 2002 09:18:05 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Dave Jones <davej@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: sound/oss updates.
In-Reply-To: <20020227031241.F9189@suse.de>
Message-ID: <Pine.LNX.4.33.0202270911270.665-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Dave Jones wrote:

> On Tue, Feb 26, 2002 at 04:15:34PM -0800, Linus Torvalds wrote:
>  > On Tue, 26 Feb 2002, Dave Jones wrote:
>  > > Is it worth me sending you the pending bits I have for sound/oss/ ?
>  > > Is this going to be around in 2.6, or is this just a transitional thing?
>  > > Or do you want them through Jaroslav ?
>  > 
>  > I think we'll keep OSS around until people just don't care any more. Which 
>  > _may_ be before 2.6, but I doubt it.
>  > 
>  > Ask Jaroslav if he is interested, but I suspect the answer will be to send 
>  > them to me.
> 
>  Hi Jaroslav,
>   So, theres currently quite a lot of updates in sound/oss in 2.5-dj
>   that are mostly forward ports of fixes from 2.4. What would you
>   prefer here ?
>   - Me splitting them up into per driver patches for you
>     to include & then forward to Linus
>   - You grabbing the sound/oss chunk from 2.5.5-dj2 patch en-masse.
>   - Me forwarding straight to Linus
>   - Something else ?

It would be probably good to maintain the /sound tree from one place, so
I can maintain the /sound/oss tree as well - allowing Linus to do 
something more interesting ;-)

I am ready to maintain all sound related updates for 2.5.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

