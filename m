Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317753AbSGKESJ>; Thu, 11 Jul 2002 00:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSGKESI>; Thu, 11 Jul 2002 00:18:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21004 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317753AbSGKESH>; Thu, 11 Jul 2002 00:18:07 -0400
Date: Thu, 11 Jul 2002 01:19:34 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Cort Dougan <cort@fsmlabs.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
Message-ID: <20020711041934.GB6895@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Cort Dougan <cort@fsmlabs.com>, "David S. Miller" <davem@redhat.com>,
	rusty@rustcorp.com.au, adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
	linux-kernel@vger.kernel.org
References: <200207041724.KAA06758@adam.yggdrasil.com> <20020711124830.26e2388b.rusty@rustcorp.com.au> <20020710.194555.88475708.davem@redhat.com> <20020710220244.K18791@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710220244.K18791@host110.fsmlabs.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 10, 2002 at 10:02:44PM -0600, Cort Dougan escreveu:
> Large PTE's aren't free either, though.  Cheap enough to implement but
> there's some fragmentation that isn't easy to deal with in some
> pathological cases.  The virtual space is pretty tight on some archs
> already.
> 
> A lot of stock distributions load most drivers as modules so a machine well
> stocked with devices may run into trouble.

yes, that is what I like about modules: for general purpose distros and also
for debugging.

- Arnaldo
