Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbRFYUC5>; Mon, 25 Jun 2001 16:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265907AbRFYUCr>; Mon, 25 Jun 2001 16:02:47 -0400
Received: from adsl-65-68-16-200.dsl.ltrkar.swbell.net ([65.68.16.200]:32603
	"EHLO etmain.edafio.com") by vger.kernel.org with ESMTP
	id <S265908AbRFYUCa> convert rfc822-to-8bit; Mon, 25 Jun 2001 16:02:30 -0400
Subject: RE: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Date: Mon, 25 Jun 2001 14:57:39 -0500
Message-ID: <3BDF3E4668AD0D49A7B0E3003B294282BC96@etmain.edafio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: VIA Southbridge bug (Was: Crash on boot (2.4.5))
content-class: urn:content-classes:message
Thread-Index: AcD9QCGJYswK5O41R2OKPs0tzeAQXgAcLgrw
From: "Andy Ward" <andyw@edafio.com>
To: "Steven Walter" <srwalter@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd love to help out with testing (alas, my kernel coding skills aren't
up to fixing this kind of problem).  Heck, if it trashes my linux
install, no biggie... I've got it ghosted to an image elsewhere...

Anyone wanting to work on this just drop me an email.

-- andyw

-----Original Message-----
From: Steven Walter [mailto:srwalter@yahoo.com]
Sent: Monday, June 25, 2001 1:33 AM
To: Andy Ward
Cc: linux-kernel@vger.kernel.org
Subject: VIA Southbridge bug (Was: Crash on boot (2.4.5))


Great, glad to here it.  Who (if anyone) is still attempting to unravel
the puzzle of the Via southbridge bug?  You, Andy, should try and get in
touch with them and help debug this thing, if you're up to it.

On Mon, Jun 25, 2001 at 01:17:57AM -0500, Andy Ward wrote:
> Well, I have tried your suggestion, and it works beautifully...  The
> only change I made was to the cpu type (to 686), and everything *just*
> works now...  Thanks, all!!!
> 
> > From the look of things, you're being bitten by the VIA southbridge
> > problem.  As I've gathered, its some sort of interaction with that
chip
> > and the 3DNow! fast copy routines the kernel uses.
> > 
> > If you compile the kernel for a 686, does the problem go away?  What
> > about 586 or lower?  If so, I believe there are some people working
on
> > finding common aspects of the hardware that experience this problem,
> > though I don't remember who.  You should get in contact with them,
or
> > they might get into contact with you.
> > 
> > Good luck on working this out.
> > -- 
> > -Steven
> > In a time of universal deceit, telling the truth is a revolutionary
act.
> > 			-- George Orwell
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
