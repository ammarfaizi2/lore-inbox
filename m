Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSBPAPa>; Fri, 15 Feb 2002 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSBPAPV>; Fri, 15 Feb 2002 19:15:21 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:42451
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S292294AbSBPAPJ>; Fri, 15 Feb 2002 19:15:09 -0500
Date: Fri, 15 Feb 2002 19:15:03 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215171952.D15406@thyrsus.com>
Message-ID: <Pine.LNX.4.44.0202151902070.16872-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Eric S. Raymond wrote:

> Dave Jones <davej@suse.de>:
> >  The point being made is that you constantly refuse to listen.
> >  You ask for an opinion, and when something comes back that isn't
> >  what you expect, you run off and write something completely 
> >  different just to appease some fabled Aunt Tilley, then come
> >  back and say "Ok, how about now?".
> 
> I honestly don't undestand how this myth got started, Dave.
> 
> >From my point of view, I have been busting my ass trying to *extract*
> requirements from Linus and other people with a stake.  What guidance
> I get is vague and contradictory.  My proposals to address it get ignored.
> Everything I do right gets written off and teensy side issues get 
> inflated into monsters.
> 
> It's utterly maddening to hear people accuse me of not listening when
> I spend so damn much effort trying to do what they want for so little
> reward...

Eric....

Again...  Just like I said to you in private email...

Show us that you're able to write a 1 for 1 functional correspondance
between CML1 and CML2 and propose that for inclusion into 2.5.  This will
already have the advantage of using a common engine to parse the config
language regardless of the frontend used, along with the readability and
compactness of CML2.  This should not cause a too big cultural change.

Wait for a month or two while developers get used to it.  Then and only then
could you start discussion about advanced CML2 possibilities and features.  
REmember that Linux development only works like a car that you propose
individual parts individually and let people comment on them.  Providing the
whole car already assembled with a "turn key"  package simply doesn't work
with most car hackers.

As a bonus to further stimulate acceptance of CML2, make it work with the
tools that most people already have i.e. Python 1.5.


Nicolas

