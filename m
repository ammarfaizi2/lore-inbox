Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSGPQx2>; Tue, 16 Jul 2002 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSGPQx1>; Tue, 16 Jul 2002 12:53:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47108 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317887AbSGPQx1>; Tue, 16 Jul 2002 12:53:27 -0400
Date: Tue, 16 Jul 2002 07:56:12 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
Message-ID: <20020716105612.GB1728@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bob Dunlop <bob.dunlop@xyzzy.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
References: <200207151111.22555.henrique@cyclades.com> <m37kjvg6nq.fsf@defiant.pm.waw.pl> <20020716135818.GB1231@conectiva.com.br> <20020716164817.B10878@xyzzy.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716164817.B10878@xyzzy.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 16, 2002 at 04:48:17PM +0100, Bob Dunlop escreveu:
> > This is becoming a FAQ... see net/core/dev.c, line 907 on 2.5:
> > 
> >     /* skb->nh should be correctly
> >        set by sender, so that the second statement is
> >        just protection against buggy protocols.
> >      */

<SNIP>

> Not exactly a FAQ answer though:

Agreed, but I talked with Henrique privately (in portuguese) and give a
long explanation with examples of how to fix that.

- Arnaldo
