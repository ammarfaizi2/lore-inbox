Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSLITBY>; Mon, 9 Dec 2002 14:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbSLITBY>; Mon, 9 Dec 2002 14:01:24 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:4114 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265978AbSLITBX>; Mon, 9 Dec 2002 14:01:23 -0500
Date: Mon, 9 Dec 2002 17:08:48 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>, erik@hensema.xs4all.nl,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/pci deprecation?
Message-ID: <20021209190848.GW17067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	erik@hensema.xs4all.nl, linux-kernel@vger.kernel.org
References: <997222131F7@vcnet.vc.cvut.cz> <slrnav3qp5.1c2.usenet@bender.home.hensema.net> <20021207131559.GA737@gallifrey> <20021207174658.GD10322@conectiva.com.br> <20021209200318.A31996@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021209200318.A31996@bitwizard.nl>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 09, 2002 at 08:03:19PM +0100, Rogier Wolff escreveu:
> On Sat, Dec 07, 2002 at 03:46:58PM -0200, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Dec 07, 2002 at 01:15:59PM +0000, Dr. David Alan Gilbert escreveu:
> > > * Erik Hensema (usenet@hensema.xs4all.nl) wrote:
> > > > 
> > > > Every half-decent installer autodetects all PCI devices. AND had lspci
> > > > installed in the install image.
> > > 
> > > Yes, but wait till you find yourself stuck on a weird embedded board
> > > with a small flash and a serial console and you are trying to debug the
> > > PCI device you've built.
> > 
> > In this weird embedded board with small flash it'd be lovely to save one
> > more page (or perhaps more) in the kernel image, no? :-)
> 
> Agreed. But -=*if*=- I want to. 
> 
> I would personally prefer to spend the page in the (compressed in flash!)
> kernel image than the nine pages or so for "lspci" (possibly compressed
> as well). 

wow, is lspci so bloated? 8) And I didn't objected to having it as a user
selectable option :-)

- Arnaldo
