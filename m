Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130525AbQLNRgz>; Thu, 14 Dec 2000 12:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbQLNRgp>; Thu, 14 Dec 2000 12:36:45 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:7505 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130125AbQLNRgb>; Thu, 14 Dec 2000 12:36:31 -0500
Date: Thu, 14 Dec 2000 19:13:26 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Chad Schwartz <cwslist@main.cornernet.com>
cc: Mark Orr <markorr@intersurf.com>, linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
In-Reply-To: <Pine.LNX.4.30.0012140833520.14206-100000@main.cornernet.com>
Message-ID: <Pine.LNX.4.21.0012141902570.2377-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah. most of this crap is manufactured as all-in-1 chips. (IDE, FDC, SER,
> PAR, etc.) and right along with that, you get 2 16550AFN's. Now. they
> hyped the heck out of 16550's when they came out, because "You can use
> your 28.8kbps modem without overruns!". Yeah. clocking it at 38400 or
> 57600 on a system doing NOTHING ELSE BUT SERIAL.
> 
> For a little extra cost - approx. $2.50 (this number could skew a bit,
> depending on in what quantity they buy), they could put 16652's in there.

In that case you're talking a few dollars on a motherboard that costs at
least $100 to produce. I've seen this with all hardware I've seen : The
famous HP scanner series come with some kind of totally shitty SCSI card
just to save $15 or so. 

> Not much support for it on an enduser system yet (our serial.c does, but
> the MS folks dont support 'em in their generic driver, I dont think) so I
> think this has some weight in why it doesn't become defacto standard,
> either.
> 
> > Well.. Why is the i386 the defacto standard ? There architectures that are
> > a lot better. Reason it is that the some big company used it, and it got
> > populair.
> 
> Heh. Well, serial doesn't even have anything to do with architecture. As
> long as the machine supports addressable I/O, its capable of running a
> UART.

I know. I just named the Intel as an example. The Alpha architecture is on
most things superiours to the Intel, en the current PIII arcitecture still
has the some bloat of the old archtecture carried along, thing that comes
in mind is the old 80x86 compability mode.

My point was that getting rid of something that most users have is very
hard, even if the're better things on the market.

> And what kind of serial ports do you find on your Alpha?  16550's!  Your
> PowerPC?  16550's!  Your PA-RISC box? 16550's!  Hey! Even RS/6000's use
> 16550's!

I want an Alpha.. That's my gift I give to myself after I graduate ;)
 
> So while i concur with your statement,  it still doesn't explain why the
> business hasn't chosen to move on yet.
> NOTE: The same can also be stated about FLOPPY DRIVES.  Why on EARTH would
> we want 1.44mb media - on a drive that costs $15, and media that costs
> $.10/ea - when there are things like Zipdrives, where you can get
> 100mb internal drives for $50, and media for $4? (Thats what FLOPPY DRIVES
> used to cost!!  $60 for the drive, $1-2/ea for the media.)

1.44 MB is anchient, and hardlike suitable for anything else then a recue
disk. Problem that when the 3.5 inch disk was introduced it was the only
thing that was cheap and available on the market. So it became a standard,
and it is still widely used.

Today an LS drive can keep 120 MB, that is a lot better, especially if you
realize what the avarage diskstorage is today.

> > Indeed.. Why do they save $15 bucks on a modem chipset, and replace it
> > with a buggy software driven solution... Making things as cheap as
> > possible, to make sure the're chaper then their compatitor.
> 
> Good point.  But in this particular model, it obviously explains why
> electronics technology expands in the particular way that it does.
> 
> In the year 1970, everyone thought that we'd have transporter beams and
> spaceships and computers named Hal in the year 2000.  What do we *REALLY*
> have?  Technology that makes things more CONVENIENT for people.  They also
> CATER to people who don't want to spend any money.
> 
> Celphones. Pagers. Microwaves.
> 
> Hey. we even have Web-based grocery delivery guys that
> arrive in pretty vans. and all you had to do was click!
> 
> Our computers use parts that were designed 10 years previous, because
> nobody wants to spend the money on newer and better stuff.

Indeed.. People want to pay $.10 to sit on the first row in the theatre. I
choose to pay for good hardware that I buy, plug in and it works. Nog plug
in, install 20 megs of software, and then the bloody thing still refuses
to work :(

> Chad


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
