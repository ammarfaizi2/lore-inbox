Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRFWXdq>; Sat, 23 Jun 2001 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263318AbRFWXdh>; Sat, 23 Jun 2001 19:33:37 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:48531 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263329AbRFWXdY>; Sat, 23 Jun 2001 19:33:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft and Xenix.
Date: Sat, 23 Jun 2001 10:07:54 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15DZbq-0008D8-00@roo.home>
In-Reply-To: <E15DZbq-0008D8-00@roo.home>
MIME-Version: 1.0
Message-Id: <01062310075401.00696@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 June 2001 18:41, Alan Chandler wrote:
> I am not subscribed to the list, but I scan the archives and saw the
> following.  Please cc e-mail me in followups.

I've had several requests to start a mailing list on this, actually...  Might 
do so in a bit...

> I was working (and still am) for a UK computer systems integrator called
> Logica.  One of our departments sold and supported Xenix (as distributor
> for Microsoft? - all the manuals had Logica on the covers although there
> was at least some mention of Microsoft inside) in the UK.  At the time it

I don't suppose you have any of those manuals still lying around?

> It was more like (can't remember exactly when) 1985/1986 that Xenix got
> ported to the IBM PC.

Sure.  Before that the PC didn't have enough Ram.  Dos 2.0 was preparing the 
dos user base for the day when the PC -would- have enough ram.

Stuff Paul Allen set in motion while he was in charge of the technical side 
of MS still had some momentum when he left.  Initially, Microsoft's 
partnership with SCO was more along the lines of outsourcing development and 
partnering with people who knew Unix.  But without Allen rooting for it, 
Xenix gradually stopped being strategic.  Gates allowed his company to be led 
around by the nose by IBM, and sucked into the whole SAA/SNA thing (which DOS 
was the bottom tier of along with a bunch of IBM big iron, and which OS/2 
emerged from as an upgrade path bringing IBM mainframe technology to 
higher-end PCs.)

IBM had a unix, AIX, which had more or less emerged from the early RISC 
research (the 701 project?  Lemme grab my notebook...)

Ok, SAA/SNA was "Systems Application Architecture" and "Systems Network 
Architecture", which was launched coinciding with the big PS/2 announcement 
on April 2, 1987.  (models 50, 60, and 80.)  The SAA/SNA push also extended 
through the System/370 and AS400 stuff too.  (I think 370's the mainframe and 
AS400 is the minicomputer, but I'd have to look it up.  One of them (AS400?) 
had a database built into the OS.  Interestingly, this is where SQL 
originated (my notes say SQL came from the System/370 but I have to 
double-check that, I thought the AS400 was the one with the built in 
database?).  In either case, it was first ported to the PC as part of SAA.  
We also got the acronym "API" from IBM about this time.)  Dos 4.0 was new, it 
added 723 meg disks, EMS bundled into the OS rather than an add-on (the 
Lotus-Intel-Microsoft Expanded Memory Specification), and "DOSShell" which 
conformed to the SAA graphical user interface guidelines.  (Think an 
extremely primitive version of midnight commander.)

The PS/2 model 70/80 (desktop/tower versions of same thing) were IBM's first 
386 based PC boxes, which came with either DOS 3.3, DOS 4.0, OS/2 (1.0), or 
AIX.

AIX was NOT fully SAA/SNA compliant, since Unix had its own standards that 
conflicted with IBM's.  Either they'd have a non-standard unix, or a non-IBM 
os.  (They kind of wound up with both, actually.)  The IBM customers who 
insisted on Unix wanted it to comply with Unix standards, and the result is 
that AIX was an outsider in the big IBM cross-platform push of the 80's, and 
was basically sidelined within IBM as a result.  It was its own little world.

skip skip skip skip (notes about boca's early days...  The PC was launched in 
August 1981, list of specs, xt, at, specs for PS/2 models 25/30, 50, 70/80, 
and the "pc convertable" which is a REALLY ugly laptop.)

Here's what I'm looking for:

AIX was first introduced for the IBM RT/PC in 1986, which came out of the 
early RISC research.  It was ported to PS/2 and S/370 by SAA, and was based 
on unix SVR2.  (The book didn't specify whether the original version or the 
version ported to SAA was based on SVR2, I'm guessing both were.)

AIX was "not fully compliant" with SAA due to established and conflicting 
unix standards it had to be complant with, and was treated as a second class 
citizen by IBM because of this.  It was still fairly hosed according to the 
rest of the unix world, but IBM mostly bent standards rather than breaking 
them.

Hmmm...  Notes on the history of shareware (pc-write/bob wallace/quiicksoft, 
pc-file/pc-calc/jim button/buttonware, pc-talk/andrew flugelman, apparently 
the chronological order is andrew-jim-bob, and bob came up with the name 
"shareware" because "freeware" was a trademark of Headlands Press, Inc...)  
Notes on the IBM Risc System 6000 launch out of a book by Jim Hoskins (which 
is where micro-channel came from, and also had one of the first cd-rom 
drives, scsi based, 380 ms access time, 150k/second, with a caddy.)  Notes on 
the specifications of the 8080 and 8085 processors, plus the Z80

Sorry, that risc thing was the 801 project led by John Cocke, named after the 
building it was in and started in 1975.

Ah, here's the rest of it:

The IBM Person Computer RT (Risc Technology) was launched in January 1986 
running AIX.  The engineers (in Austin) whent on for the second generation 
Risc System 6000 (the RS/6000) with AIX version 3, launched February 15 1990.
The acronym "POWER" stands for Performance Optimized WIth Enhanced Risc.

Then my notes diverge into the history of ethernet and token ring (IEEE 802.3 
and 802.5, respectively.  The nutshell is that ethernet was a commodity and 
token ring was IBM only, and commodity out evolves proprietary every time.  
The second generation ethernet increased in speed 10x while the second 
generation token ring only increase 4x, and ethernet could mix speeds while 
token ring had to be homgeneous.  Plus ethernet moved to the "baseT" stuff 
which was just just so much more reliable and convenient, and still cheaper 
even if you had to purchase hubs because it was commodity.)

> instead) and I was comparing Xenix, GEM (remember that - for a time it
> looked like it might be ahead of windows) and Microsoft Windows v 1 .  We

Ummm...  GEM was the Geos stuff?  (Yeah I remember it, I haven't researched 
it yet though...)

> chose Windows in the end for its graphics capability although by the time
> we started development it was up to v2 and we were using 286's (this was
> 1987/88).

I used windows 2.0 briefly.  It was black and white and you could watch the 
individual pixels appear on the screen as it drew the fonts.  (It looked 
about like somebody writing with a pen.  Really fast for writing with a pen, 
but insanely slow by most other standards.  Scrolling the screen was an 
excuse to take a sip of beverage du jour.)

The suckiness of windows through the 80's has several reasons.  The first 
apple windowing system Gates saw was the LISA, -before- the macintosh, and 
they actually had a pre-release mac prototype (since they were doing 
application software for it) to clone.  Yet it took them 11 years to get it 
right.

In part this was because PC graphics hardware really sucked.  CGA, hercules, 
EGA...  Painful.  Black and white frame buffers pumped through an 8 mhz ISA 
bus.  (Even the move to 16 bit bus with the AT didn't really help matters too 
much.)

In part, when Paul Allen left, Microsoft's in-house technical staff just 
disintegrated.  (Would YOU work for a company where marketing had absolute 
power?)  The scraps of talent they had left mostly followed the agenda set by 
IBM (DOS 4/5, OS/2 1.0/1.1).  A lot of other stuff (like the AIX work) got 
outsourced.

Windows was Gates' pet project (I suspect an ego thing with steve jobs may 
have been involved a bit, but they BOTH knew that the stuff from Xerox parc 
was the future).  He didn't want to outsource it, but the in-house resources 
available to work on it were just pathetic.

There are a couple good histories of windows (with dates, detailed feature 
lists, and screen shots of the various versions) available online.  And if 
you're discussing windows, you not only have to compare it with the Macintosh 
but at least take a swipe at the Amiga and Atari ST as well.  And OS/2's 
presentation manager development, and of course the early X days (The first 
version of X came out of MIT in 1984, the year the macintosh launched.  
Unfortunatley in 1988 X got caught in a standards committe and development 
STOPPED for the next ten years.  Development finally got back in gear with 
the XFree86 guys told X Open where it could stick its new license a year or 
two back and finally decided to forge ahead on their own, and they've been 
making up for lost time ever since but they've had a LOT of ground to cover.  
Using 3d accelerator cards to play MPEG video streams is only now becoming 
feasable to do under X.  And it SHOULD be possible to do that through a 
100baseT network, let alone gigabit, but the layering's all wrong...)

> Logica sold out its Xenix operation to Santa-Cruz around 1987 (definately
> before October 1987) because we couldn't afford the costs of developing the
> product (which makes me think that we had bought it out from Microsoft - at
> least in the UK).  By then we had switched our PDP 11s to System V (I also
> remember BUYING an editor called "emacs" for use on it:-) ).

That would be the X version of emacs.  And there's the explanation for the 
split between GNU and X emacs: it got forked and the closed-source version 
had a vew  years of divergent development before opening back up, by which 
point it was very different to reconcile the two code bases.

Such is the fate of BSD licensed code, it seems.  At least when there's money 
in it, anyway...

And THAT happy experience is why Richard Stallman stopped writing code for a 
while and instead started writing licenses.  The GPL 1.0 decended directly 
from that (and 2.0 from real world use/experience/users' comments in the 
field)

(Yes, I HAVE been doing a lot of research.  I think I'll head down to the UT 
library again this afternoon, actually...)

Rob

