Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPCO6>; Fri, 15 Dec 2000 21:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLPCOs>; Fri, 15 Dec 2000 21:14:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:41733 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129183AbQLPCO3>; Fri, 15 Dec 2000 21:14:29 -0500
Date: Fri, 15 Dec 2000 19:39:32 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [paperboy@g2news.com: Client Server NEWS FLASH: Linus Savages Red Hat 7.0]
Message-ID: <20001215193932.A5880@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI Guys, This just went over the wire from CSN.  Might need some damage 
control.

Jeff


----- Forwarded message from PaperBoy <paperboy@g2news.com> -----

Return-Path: <paperboy@g2news.com>
Received: from stmpy-1.cais.net (stmpy-1.cais.net [205.252.14.71])
	by vger.timpanogas.org (8.9.3/8.9.3) with ESMTP id SAA05538
	for <jmerkey@timpanogas.com>; Fri, 15 Dec 2000 18:26:12 -0700
Received: from SERVER ([209.8.170.98])
	by stmpy-1.cais.net (8.11.1/8.11.1) with SMTP id eBG0UUH66549
	for <jmerkey@timpanogas.com>; Fri, 15 Dec 2000 19:30:30 -0500 (EST)
Reply-To: <paperboy@g2news.com>
From: "PaperBoy" <paperboy@g2news.com>
To: <jmerkey@timpanogas.com>
Subject: Client Server NEWS FLASH: Linus Savages Red Hat 7.0
Date: Fri, 15 Dec 2000 19:18:44 -0500
Message-ID: <047901c066f8$0298ba20$0c01a8c0@SERVER>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_047A_01C066CE.19C2B220"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300


      Client Server NEWS 380.2 NewsFlash
The Very Independent Observer of Microsoft, Windows 2000/NT and Other
Phenomena
                  December 15, 2000

Linus Savages Red Hat 7.0
By Maureen O'Gara

Friday, December 15, 2000 - Linus Torvalds, the father of Linux,
trashed Red Hat 7.0, the market leader's latest rev of its Linux
distribution, as "basically unusable" in a posting he made to the
Linux kernel mailing list yesterday.

The text of the blistering appraisal reads as follows:

"Quite frankly, anybody who uses Red Hat 7.0 and their broken
compiler for anything is going to have trouble.

"I don't know why RH decided to do their idiotic gcc-2.96 release
(it certainly wasn't approved by any technical gcc people - the gcc
people were upset about it too), and I find it even more surprising
that they apparently KNEW that the compiler they were using was
completely broken. They included another (non-broken) compiler, and
called it "kgcc."

"'kgcc' stands for "kernel gcc", apparently because (a) they
realized that a miscompiled kernel is even worse than miscompiling
some random user applications and (b) gcc-2.96 is so broken that it
requires special libraries for C++ vtable chunks handling that is
different, so the working gcc can only be used with programs that do
not need such library support. Namely the kernel.

"In case it wasn't obvious yet, I consider Red Hat 7.0 to be
basically unusable as a development platform, and I hope RH
downgrades their compiler to something that works better RSN. It
apparently has problems compiling stuff like the CVS snapshots of X
etc too (and obviously, anything you compile under gcc-2.96 is not
likely to work anywhere else except with the broken libraries)."

Red Hat CEO Matthew Szulik, who said he wasn't really the right
person to respond to Linus' charges, also said that Red Hat has been
expecting a denunciation like this. The rumbling has been going on
for months and in many corners.

The GCC Steering Committee got its hackles up about it back in early
October when it publicly branded the so-called GCC 2.96 compiler
unfit for production release. It said it was a "development branch"
of what would eventually be GCC 3.0. "GCC 2.96 is not a formal GCC
release," "nor will there ever be such a release." It's merely a way
station on the road to GCC 3.0.

The GCC Steering Committee said 2.96 produces "object files that are
not compatible with those produced by either GCC 2.95.2 or the
forthcoming GCC 3.0. Therefore, programs built with these snapshots
will not be compatible with any official GCC release. Actually, C
and Fortran code will probably be compatible, but code in other
languages, most notably C++ due to incompatibilities in symbol
encoding (``mangling''), the standard library and the application
binary interface (ABI), is likely to fail in some way. Static
linking against C++ libraries may make a binary more portable, at
the cost of increasing file size and memory use."

Red Hat is famous for pushing the envelop in its dot 0 releases and
using bleeding-edge technology. Red Hat Linux 5.0 was widely
criticized when it came out in 1998 for using glib libraries that
were not ready for prime time.

The instability of Red Hat 5.0 put Informix, the first serious
enterprise ISV to port to Linux, in a quandary. It ported the
Informix SE database to the more stable SuSE instead, then came up
against the popularity issue. Red Hat simply had more market share
than SuSE. Informix decided it had to do a special port to Red Hat
since the code written for the less radical SuSE would not run on
Red Hat, a familiar, if distasteful, problem for any old-line Unix
ISV.

Programs not specifically ported to Red Hat 5.0 like StarOffice, for
instance, broke because their libraries weren't in synch.

The same problem exists with Red Hat 7.0. Programs written for it
will not work on other Linux distributions.

Red Hat critics accuse Red Hat of using the device to differentiate
itself or appear to differentiate itself from its more conservative
rivals, who abstain from using such edge-of-the-development-curve
technologies as although it were unripe fruit, and garner a lead
over them in the marketplace.

They claim the technique is a disservice to Red Hat customers and
say there's general disconnect between Red Hat engineers with their
gee-whiz widgetry and the marketplace, which requires stability.
They also claim that Red Hat is doing a disservice to the Linux
movement per se. Now that Linux is poised on the threshold of
acceptance in the corporate world integrity and reliability should
be the watchwords.

Red Hat CTO Michael Tiemann recently defended Red Hat's decision to
use GCC 2.96 against the hue and cry that erupted in the Linux
community in the wake of Red Hat 7.0's release in September. He said
that "it appears that no better technical decision could have been
made" because all the other choices weren't any better - given the
complex series of requirements Red Hat had - and rather than go
backwards, its decision could push the development of GCC 3.0, which
Tiemann described as "quite a ways off" and "very much a work in
progress."

Tiemann said if critics wanted someone to blame, "then you might as
well blame me" for the 2.96 decision. "Frankly, I didn't even
consider C++ ABI compatibility with other Linux vendors, since I
think that's a losing proposition until everyone is using gcc3. We
were already incompatible, since there are a mix of egcs and gcc
versions involved."

             - - - - - - - - - - - -

Catch up on all the e-commerce news:  www.onlinereporter.com
Linux business news is at www.linuxgram.com

Client Server News 2000, The Online Reporter and LinuxGram are
published weekly by G2 Computer Intelligence Inc.
http://www.g2news.com ; 323 Glen Cove Avenue; Sea Cliff, NY 11579
USA;
Tel.:516 759-7025 Fax: 516 759-7028.
Send press releases to news@g2news.com
Available at quantity discount to associations, groups, departments
and companies. paperboy@g2news.com

Europe:  Simon Thompson  simon@g2news.com
Tel: (44) +01280 848 030; Fax: (44) +01280 848 017

(c) Copyright 2000, G2 Computer Intelligence, Inc.

Comments? Subscription, permission to post to a web site or reprint
info?: e-mail: paperboy@g2news.com

             - - - - - - - - - - - -



#1 in news coverage of Windows NT, Microsoft and related phenomena like
Linux
----------------------------------


Client Server NEWS FLASH: Linus Savages Red Hat 7.0

      Client Server NEWS 380.2 NewsFlash
The Very Independent Observer of Microsoft, Windows 2000/NT and Other Phenomena
                  December 15, 2000

Linus Savages Red Hat 7.0
By Maureen O'Gara

Friday, December 15, 2000 - Linus Torvalds, the father of Linux, 
trashed Red Hat 7.0, the market leader's latest rev of its Linux 
distribution, as "basically unusable" in a posting he made to the 
Linux kernel mailing list yesterday.

The text of the blistering appraisal reads as follows:

"Quite frankly, anybody who uses Red Hat 7.0 and their broken 
compiler for anything is going to have trouble.

"I don't know why RH decided to do their idiotic gcc-2.96 release 
(it certainly wasn't approved by any technical gcc people - the gcc 
people were upset about it too), and I find it even more surprising 
that they apparently KNEW that the compiler they were using was 
completely broken. They included another (non-broken) compiler, and 
called it "kgcc."

"'kgcc' stands for "kernel gcc", apparently because (a) they 
realized that a miscompiled kernel is even worse than miscompiling 
some random user applications and (b) gcc-2.96 is so broken that it 
requires special libraries for C++ vtable chunks handling that is 
different, so the working gcc can only be used with programs that do 
not need such library support. Namely the kernel.

"In case it wasn't obvious yet, I consider Red Hat 7.0 to be 
basically unusable as a development platform, and I hope RH 
downgrades their compiler to something that works better RSN. It 
apparently has problems compiling stuff like the CVS snapshots of X 
etc too (and obviously, anything you compile under gcc-2.96 is not 
likely to work anywhere else except with the broken libraries)."

Red Hat CEO Matthew Szulik, who said he wasn't really the right 
person to respond to Linus' charges, also said that Red Hat has been 
expecting a denunciation like this. The rumbling has been going on 
for months and in many corners. 

The GCC Steering Committee got its hackles up about it back in early 
October when it publicly branded the so-called GCC 2.96 compiler 
unfit for production release. It said it was a "development branch" 
of what would eventually be GCC 3.0. "GCC 2.96 is not a formal GCC 
release," "nor will there ever be such a release." It's merely a way 
station on the road to GCC 3.0.

The GCC Steering Committee said 2.96 produces "object files that are 
not compatible with those produced by either GCC 2.95.2 or the 
forthcoming GCC 3.0. Therefore, programs built with these snapshots 
will not be compatible with any official GCC release. Actually, C 
and Fortran code will probably be compatible, but code in other 
languages, most notably C++ due to incompatibilities in symbol 
encoding (``mangling''), the standard library and the application 
binary interface (ABI), is likely to fail in some way. Static 
linking against C++ libraries may make a binary more portable, at 
the cost of increasing file size and memory use."

Red Hat is famous for pushing the envelop in its dot 0 releases and 
using bleeding-edge technology. Red Hat Linux 5.0 was widely 
criticized when it came out in 1998 for using glib libraries that 
were not ready for prime time. 

The instability of Red Hat 5.0 put Informix, the first serious 
enterprise ISV to port to Linux, in a quandary. It ported the 
Informix SE database to the more stable SuSE instead, then came up 
against the popularity issue. Red Hat simply had more market share 
than SuSE. Informix decided it had to do a special port to Red Hat 
since the code written for the less radical SuSE would not run on 
Red Hat, a familiar, if distasteful, problem for any old-line Unix 
ISV.

Programs not specifically ported to Red Hat 5.0 like StarOffice, for 
instance, broke because their libraries weren't in synch.

The same problem exists with Red Hat 7.0. Programs written for it 
will not work on other Linux distributions. 

Red Hat critics accuse Red Hat of using the device to differentiate 
itself or appear to differentiate itself from its more conservative 
rivals, who abstain from using such edge-of-the-development-curve 
technologies as although it were unripe fruit, and garner a lead 
over them in the marketplace. 

They claim the technique is a disservice to Red Hat customers and 
say there's general disconnect between Red Hat engineers with their 
gee-whiz widgetry and the marketplace, which requires stability. 
They also claim that Red Hat is doing a disservice to the Linux 
movement per se. Now that Linux is poised on the threshold of 
acceptance in the corporate world integrity and reliability should 
be the watchwords.

Red Hat CTO Michael Tiemann recently defended Red Hat's decision to 
use GCC 2.96 against the hue and cry that erupted in the Linux 
community in the wake of Red Hat 7.0's release in September. He said 
that "it appears that no better technical decision could have been 
made" because all the other choices weren't any better - given the 
complex series of requirements Red Hat had - and rather than go 
backwards, its decision could push the development of GCC 3.0, which 
Tiemann described as "quite a ways off" and "very much a work in 
progress."

Tiemann said if critics wanted someone to blame, "then you might as 
well blame me" for the 2.96 decision. "Frankly, I didn't even 
consider C++ ABI compatibility with other Linux vendors, since I 
think that's a losing proposition until everyone is using gcc3. We 
were already incompatible, since there are a mix of egcs and gcc 
versions involved."

             - - - - - - - - - - - -

Catch up on all the e-commerce news:  www.onlinereporter.com 
Linux business news is at www.linuxgram.com

Client Server News 2000, The Online Reporter and LinuxGram are 
published weekly by G2 Computer Intelligence Inc. 
http://www.g2news.com ; 323 Glen Cove Avenue; Sea Cliff, NY 11579 
USA; 
Tel.:516 759-7025 Fax: 516 759-7028. 
Send press releases to news@g2news.com 
Available at quantity discount to associations, groups, departments 
and companies. paperboy@g2news.com 

Europe:  Simon Thompson  simon@g2news.com 
Tel: (44) +01280 848 030; Fax: (44) +01280 848 017 

(c) Copyright 2000, G2 Computer Intelligence, Inc. 

Comments? Subscription, permission to post to a web site or reprint 
info?: e-mail: paperboy@g2news.com


----- End forwarded message -----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
