Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbSL3SwP>; Mon, 30 Dec 2002 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbSL3SwP>; Mon, 30 Dec 2002 13:52:15 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:36616 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267032AbSL3SwO>; Mon, 30 Dec 2002 13:52:14 -0500
Date: Mon, 30 Dec 2002 17:00:35 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230190034.GG3143@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
	linux-kernel@vger.kernel.org
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 30, 2002 at 07:53:22PM +0100, Emiliano Gabrielli escreveu:
> 
> <quote who="Dave Jones">
> > On Mon, Dec 30, 2002 at 12:49:33PM +0000, John Bradford wrote:
> >  > > Well, I disagree: http://www.wiggy.net/rants/tabsvsspaces.xhtml
> >  > In my opinion, indentation in any form is irritating.
> >
> > The devfs source code is --> that way.
> >
> 
> IMHO and in my personal projects I use the following indenting rules:
> 
> 1) use TABs for _indentation_
> 2) use SPACEs for aligning
> 
> here is an exaple:
> 
> <tab><tab>if (cond) {
> <tab><tab><tab>dosometing;
> <tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
> <tab><tab><tab>       foo, bar);
> 
> where tabs are explicitated, while spaces not.
> 
> 
> I think this way combines both tab and spaces advantages, allowing each coder
> to have its own indentation width, but NEVER destroing the aspect of the code.
> 
> This is only my opinion :-P

I second that.

- Arnaldo
