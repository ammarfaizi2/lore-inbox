Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSL3Sfy>; Mon, 30 Dec 2002 13:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSL3Sfy>; Mon, 30 Dec 2002 13:35:54 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:33800 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267048AbSL3Sfx>; Mon, 30 Dec 2002 13:35:53 -0500
Date: Mon, 30 Dec 2002 16:43:42 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: John Bradford <john@grabjohn.com>
Cc: Markus Pfeiffer <profmakx@profmakx.org>, sam@ravnborg.org,
       lm@work.bitmover.com, mail@hannes-reinecke.de,
       linux-kernel@vger.kernel.org
Subject: Re: Sparc port still maintained in 2.5
Message-ID: <20021230184342.GE3143@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	John Bradford <john@grabjohn.com>,
	Markus Pfeiffer <profmakx@profmakx.org>, sam@ravnborg.org,
	lm@work.bitmover.com, mail@hannes-reinecke.de,
	linux-kernel@vger.kernel.org
References: <200212301913.28503.profmakx@profmakx.org> <200212301827.gBUIRgPH002681@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212301827.gBUIRgPH002681@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 30, 2002 at 06:27:42PM +0000, John Bradford escreveu:
> > > > I have a spare Alpha box (in theory I made need it some day if we ever
> > > > decide to support Tru64 but that seems like a small market).  I don't
> > > > know how useful it is but I could put it up outside our firewall if
> > > > that helped.  I'd have to install Linux on it and I'm booked up until
> > > > Jan 9th but if you still need it then let me know.
> > >
> > > Hi Larry, nice offer. But I personally would not have time hacking on
> > > Alpha. Others may find it usefull though.
> > >
> > 
> > Well, I have an Alpha System here myself and am also "hacking" on
> > it. But one has also to ask oneself if there is any demand (apart
> > from my personal demand) for a maintained Linux/Alpha >= 2.5...
 
> I'm certainly going to be interested in Linux/Sparc >= 2.5 when I can get a
> Sparc machine, (I'm hoping to help work on the 'Splack' distribution, which
> is basically an un-official Slackware-like distribution for Sparcs), with the

I'm doing the same for Conectiva Linux, the package recompilation is almost
done :-) But for now I'm using 2.4.20, with some oopses (similar to some
already reported on the sparclinux@vger.kernel.org mailing list that I already
reported to Uzi). 2.5-bk compiles and boots, but I couldn't access the machine
as serial console is not working and I only have a SS10 headless machine, I
plan to look into some of these issues when (if) I find time.

> eventual aim of moving from X86 to Sparc as my default architechture, but I'm
> not really interested in Alpha.
 
> What's the status of the 2.5 Sparc tree?

Zaitcev has sent an status some time ago:

http://marc.theaimsgroup.com/?l=linux-sparc&m=103895559102210&w=2

- Arnaldo
