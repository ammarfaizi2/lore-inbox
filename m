Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289092AbSANWOy>; Mon, 14 Jan 2002 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSANWOp>; Mon, 14 Jan 2002 17:14:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:4231
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289092AbSANWO2>; Mon, 14 Jan 2002 17:14:28 -0500
Date: Mon, 14 Jan 2002 16:59:09 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org
Subject: Penelope builds a kernel
Message-ID: <20020114165909.A20808@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario #3: Penelope goes where the geeks are surfing.

The girl geek Melvin noticed over at the computer lab is named
Penelope.  She's studying proteomics, and runs Linux on the laptop she
just bought because Linux supports the best software she can afford
for modeling protein folding.

Penelope is what the trade rags call a "power user".  She's pretty
bright, and likes computers, but she's got more important things to
think about than the details of how to configure a kernel.  Like
getting a better handle on the effect of van der Waals forces on alpha
sheets, or the latest paper on ribosomal electron transport, or why
she can't seem to meet men who don't bore the crap out of her even in
a fair-sized college town.

She's just heard about a PCMCIA card that has a MEMS array of chemical
sensors on it.  The thing could replace the bulky, balky
gel-chromatography setup she's using now, and make it unnecessary for
her to fight other students for bench time.  There's even a Linux
driver for the card (and user-space utilities to talk to it) on one of
the bio sites she uses -- way too specialized an item for her distro
to carry, and anyway she doesn't want to wait for the next release.

Penelope needs to build a kernel to support her exotic driver, but she
hasn't got more than the vaguest idea how to go about it.  The
instructions with the driver source patch tell her to apply it at the
top level of a current Linux source tree and then just say "build the
kernel" before getting off into technicalia about the user-space
tools.

She could ask that guy who's been eyeing her over at the computer lab
for help; Penelope knows what a penguin T-shirt means, and he's not
too bad-looking, if a bit on the skinny side.  On the other hand, she
knows that guys like that tend to take over the whole process when
they're trying to be helpful; they can't help displaying their prowess
and doing more than you asked for, it's biologically wired in.  And
she's learned that letting someone else take over maintaining your
equipment properly in a way you don't understand is a good way to have
it flake out on you just short of a deadline.

On the third hand, she really *doesn't* want to spend her think time
absorbing a bunch of irrelevant hardware details just to get the one
driver she needs up and running.  What she needs is some fast,
hassle-free technological empowerment, not Yet Another Learning
Experience. (And a boyfriend would be nice too, while she's wishing.)

If Penelope learns from the README file that all *she* has to do is
type "configure; make" to build a kernel that supports her hardware,
she can apply that MEMS card patch and build with confidence that the
effort is unlikely to turn into an infinite time sink.

Autoconfigure saves the day again.  That guy in the penguin T-shirt
might even be impressed...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Guard with jealous attention the public liberty.  Suspect every one
who approaches that jewel.  Unfortunately, nothing will preserve it
but downright force.  Whenever you give up that force, you are
inevitably ruined."	-- Patrick Henry, speech of June 5 1788
