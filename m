Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSKBTPp>; Sat, 2 Nov 2002 14:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKBTPE>; Sat, 2 Nov 2002 14:15:04 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:21514 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261323AbSKBTO5>; Sat, 2 Nov 2002 14:14:57 -0500
Date: Sat, 2 Nov 2002 16:21:05 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: romieu@fr.zoreil.com
Cc: Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-atm-general@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021102192105.GG27926@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	romieu@fr.zoreil.com, Bill Davidsen <davidsen@tmr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-atm-general@lists.sourceforge.net
References: <1036157313.12693.15.camel@irongate.swansea.linux.org.uk> <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com> <20021102185508.GF27926@conectiva.com.br> <20021102201917.A18951@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102201917.A18951@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 02, 2002 at 08:19:17PM +0100, romieu@fr.zoreil.com escreveu:
> > SPX was also removed (hey, it never worked anyway) and probably econet and
> > ATM will be removed as well if nobody jumps to fix it (I mean net/atm, not
> > drivers/atm, but I'm not sure the later will be useful without the former).
> 
> What's the deadline ?

Plan was for 2.6.0

- Arnaldo
