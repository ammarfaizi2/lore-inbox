Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTFBQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFBQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:26:06 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:44562 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264499AbTFBQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:26:04 -0400
Date: Mon, 2 Jun 2003 13:40:12 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
       Russell King <rmk@arm.linux.org.uk>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030602164012.GB9312@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Juan Quintela <quintela@mandrakesoft.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
References: <m2smqs7nth.fsf@neno.mitica> <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 02, 2003 at 08:59:39AM -0700, Linus Torvalds escreveu:
> 
> On 2 Jun 2003, Juan Quintela wrote:
> > 
> > /**
> >  * foo - <put something there>
> >  * @bar: number of frobnicators
> >  * @baz: self-larting on or off
> >  * @userdata: pointer to arbitrary userdata to be registered
> >  *
> >  * Description: Please, fix me
> >  */
> > int foo(long bar, long baz)
> > {
> > ...
> > 
> > Looks like a better alternative to me.
> 
> Hey, if somebody were to send me a patch (hint hint), I'd happily apply 
> it.

Hey, I'm doing this for all the parts of the net/ (and others) I touch 8)
Now we need a docbook volunteer to see if everything is going to be used
by make docs.

- Arnaldo
