Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSKBSt1>; Sat, 2 Nov 2002 13:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSKBSt1>; Sat, 2 Nov 2002 13:49:27 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:10506 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261386AbSKBStZ>; Sat, 2 Nov 2002 13:49:25 -0500
Date: Sat, 2 Nov 2002 15:55:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021102185508.GF27926@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bill Davidsen <davidsen@tmr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
References: <1036157313.12693.15.camel@irongate.swansea.linux.org.uk> <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 02, 2002 at 12:00:18AM -0500, Bill Davidsen escreveu:
> On 1 Nov 2002, Alan Cox wrote:
> 
> > On Fri, 2002-11-01 at 06:36, Linus Torvalds wrote:
> > > This never works. Be honest. Nobody takes out features, they are stuck 
> > > once they get in. 
> > 
> > Linus I've asked a couple of times about killing sound/oss off now ALSA
> > is integrated 8) While you are on the rant how about that ;)
> 
> Good point, that continues to disprove the theory that having one thing in
> the kernel prevents development of a similar feature.

SPX was also removed (hey, it never worked anyway) and probably econet and
ATM will be removed as well if nobody jumps to fix it (I mean net/atm, not
drivers/atm, but I'm not sure the later will be useful without the former).

- Arnaldo
