Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRFIDfK>; Fri, 8 Jun 2001 23:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbRFIDfA>; Fri, 8 Jun 2001 23:35:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3337 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263257AbRFIDey>;
	Fri, 8 Jun 2001 23:34:54 -0400
Date: Sat, 9 Jun 2001 00:34:40 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: John Stoffel <stoffel@casc.com>, Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106081853400.418-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0106090033080.10415-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Mike Galbraith wrote:
> On Fri, 8 Jun 2001, John Stoffel wrote:

> > I agree, this isn't really a good test case.  I'd rather see what
> > happens when you fire up a gimp session to edit an image which is
> > *almost* the size of RAM, or even just 50% the size of ram.
> 
> OK, riddle me this.  If this test is a crummy test, just how is it

Personally, I'd like to see BOTH of these tests, and many many
more.

Preferably, handed to the VM hackers in various colourful
graphs that allow even severely undercaffeinated hackers to
see how things changed for the good or the bad between kernel
revisions.

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

