Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292397AbSBPPyO>; Sat, 16 Feb 2002 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292395AbSBPPyE>; Sat, 16 Feb 2002 10:54:04 -0500
Received: from harddata.com ([216.123.194.198]:28429 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S292398AbSBPPxz>;
	Sat, 16 Feb 2002 10:53:55 -0500
Date: Sat, 16 Feb 2002 08:53:48 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216085348.A18381@mail.harddata.com>
In-Reply-To: <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <200202152209.g1FM9PZ00855@vindaloo.ras.ucalgary.ca> <20020215165029.C14418@thyrsus.com> <20020215143807.L28735@work.bitmover.com> <20020215232312.GB12204@merlin.emma.line.org> <3C6E2C1A.2000104@evision-ventures.com> <20020216130414.GB2805@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020216130414.GB2805@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sat, Feb 16, 2002 at 02:04:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 02:04:14PM +0100, Matthias Andree wrote:
> 
> The point is not to discuss fetchmail ease of use or design or whatever.
> CML2 is much younger, and in a much more maintainable language (or so I
> believe, at last; Python vs. C).

I am not so convinced about this "much more" in practice.  As an
"interested observer", but not a Python programmer, I watch for quite a
while a set of programs written in Python which affect me directly;
namely Red Hat configuration/installation tools.  Literally for years
and many releases bombs and inscrutable Python tracebacks were the
constant element of this picture.  These tools, after an obvious and
long effort, are now finally in much better shape then they used to be
but bugs are regularly reintroduced with every change.

I do not think that this happens because Red Hat has lazy or incompetent
people but because these problems are hard and Python is quite far from
silver bullet and "sliced bread" its proponent wants us to believe.  I
rather suspect that all behind the scenes machinations by Python rather
mask difficulties and make harder to eradicte those bugs.

I also cannot help not to notice that the previous bit flare-up about
CML2 on lkml was quelled to a great extent when somebody annouced that
he is rewriting required tools in C.  I had an impression that most
people then shrugged "Ok, so Eric will prototope in whatever he feels
comfortable with, we will have something acceptable later and we will
see how this works".  Now it turns out the the project got abandoned so
a requirement for a huge blob of a language (as opposed to Python 1.5
which is quite smaller), which most developers do not have or need for
anything else, is still there.  Hm..., smells very backdoor even if
it was not intended that way. 

  Michal
