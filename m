Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSDUDnp>; Sat, 20 Apr 2002 23:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDUDno>; Sat, 20 Apr 2002 23:43:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3341 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293680AbSDUDnn>;
	Sat, 20 Apr 2002 23:43:43 -0400
Date: Sun, 21 Apr 2002 00:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Ian Molton <spyro@armlinux.org>
Cc: rmk@arm.linux.org.uk, phillips@bonn-fries.net, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421034336.GJ2296@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ian Molton <spyro@armlinux.org>, rmk@arm.linux.org.uk,
	phillips@bonn-fries.net, ebiederm@xmission.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16ya3u-0000RG-00@starship> <m1elha45q0.fsf@frodo.biederman.org> <E16ycuh-0000Wg-00@starship> <20020420194851.A8051@flint.arm.linux.org.uk> <20020421035759.19c4bf7b.spyro@armlinux.org> <20020421025654.GE2296@conectiva.com.br> <20020421044616.5beae559.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 21, 2002 at 04:46:16AM +0100, Ian Molton escreveu:
> Arnaldo Carvalho de Melo Awoke this dragon, who will now respond:
> 
> > The documentation being discussed is not proprietary, it only talks about
> > a non essential proprietary tool used now by lots of kernel hackers.
> 
> well, this raises an interesting point...
> 
> should documentation be regarded as part of the package it documents or
> not?

yes, and this is the case :)

> is this 'bitkeeper documentation', 'documentation about bitkeeper', or
> 'linux kernel documentation', or what?

This is "how to use bitkeeper with the Linux kernel sources and to submit
patches to Linus", AFAIK...

As pointed out by Linus, in the jfs subtree there is similar docs, but using
CVS instead.

Ah, removing Linus from the CC list as he is not interested in this thread
at all :)

- Arnaldo
