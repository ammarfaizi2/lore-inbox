Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRKYXx6>; Sun, 25 Nov 2001 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKYXxt>; Sun, 25 Nov 2001 18:53:49 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47863
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281214AbRKYXxb>; Sun, 25 Nov 2001 18:53:31 -0500
Date: Sun, 25 Nov 2001 15:53:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Dominik Kubla <kubla@sciobyte.de>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Message-ID: <20011125155323.D30336@mikef-linux.matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Dominik Kubla <kubla@sciobyte.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011125151543.57a1159c.skraw@ithnet.com> <Pine.LNX.4.33.0111251007140.9377-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111251007140.9377-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 10:17:15AM -0800, Linus Torvalds wrote:
> 
> On Sun, 25 Nov 2001, Stephan von Krawczynski wrote:
> >
> > The "problem" effectively arises from _fast_ releasing "stable" versions.
> 
> Actually, I think that is just the _symptom_ of the basic issue: I do not
> like being a maintainer.
> 

Ok, here's *another* suggestion for future working of stable and development
kernels...

Linus,

You admit that you do not like to maintain.  We have seen that, and
unfortunately for 2.4 it is true.

Personally, I think that 2.4 was released too early.  It was when the
Internet hype was going full force, and nobody (including myself) could be
faulted for getting swept up in the wave that it was.

I'd like to suggest two possibilities.

1) Develop 2.5 until it is ready to be 2.6 and immediately give it over to
a maintainer, and start 2.7.

2) Develop 2.5 until it has the features you want to go into 2.6, and give
it over to the future 2.6 maintainer to stabalize and release it.  (there
would be two develoment kernel at the same time for a short period with this)

With both you would get to do what you like and won't get bored with, and
let people share their latest code for many to see.

Linus, can you say if you plan to do anything like this?

MF
