Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHaQtN>; Fri, 31 Aug 2001 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRHaQtD>; Fri, 31 Aug 2001 12:49:03 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:29967 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S268100AbRHaQsy>;
	Fri, 31 Aug 2001 12:48:54 -0400
Date: Fri, 31 Aug 2001 12:46:58 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e
In-Reply-To: <20010831081028.A12005@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.33.0108311244070.2899-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing,

Linuxcare has certified this laptop as being compatible with Linux 7.1
http://www.linuxcare.com/labs/certs/ibm/thinkpad/A22e/pada22e-2655-rh7-sys.epl

Did they do something that I dont know of? Is there anyone left there?

Tester

On Fri, 31 Aug 2001, Sean Hunter wrote:

> <Possibly not relevant to your problem>

It is indeed not relevant.. I dont have any pcmcia card as there is an
integrated Network adapter... (Intel EEPro100)

> I have a thinkpad and had all sorts of wierd and unpredictable crashes until I
> removed the old 3com pcmcia network card and replaced it with a new cardbus
> card.  The old card works fine in all sorts of other laptops, but the thinkpad
> just wasn't having it.
>
> Since replacing the card its worked great.
> </>
>
> Sean
>
> On Thu, Aug 30, 2001 at 06:30:27PM -0400, Tester wrote:
> > Hi,
> >
> > Its a 256 megs machine.. Celeron 800..
> > I tried using mem=255M or mem=200M and it did not change anything and
> > still crashed. The celeron A22e seems to have the same bios as the A21e...
> >
> > Btw, I received it as part of a ThinkPad University program (laptop at
> > school) from IBM with the old mandrake installed. And they IS guy of the
> > university told us that they didnt install the latest released because IBM
> > had not approved it... IBM probably already knows of the problem... So a
> > message to IBM and IBMers: Why dont you fix your known bugs?
> >
> > Also it works correctly in w2k, but win2k uses ACPI and not APM (and it
> > has a IBM pm driver...)
> >
> > Tester
> > tester@videotron.ca
> >
>

-- 
Tester
tester@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer

