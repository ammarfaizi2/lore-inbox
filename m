Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRC0Q7X>; Tue, 27 Mar 2001 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRC0Q7N>; Tue, 27 Mar 2001 11:59:13 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38154 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131429AbRC0Q7H>; Tue, 27 Mar 2001 11:59:07 -0500
Date: Mon, 26 Mar 2001 14:34:45 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: linux-kernel@vger.kernel.org, engler@csl.Stanford.EDU
Subject: Re: [ANNOUNCE] The Janitor Project
Message-ID: <20010326143445.A1383@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Werner Almesberger <Werner.Almesberger@epfl.ch>,
	linux-kernel@vger.kernel.org, engler@csl.Stanford.EDU
In-Reply-To: <20010322215215.A1052@conectiva.com.br> <20010327104321.B3974@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010327104321.B3974@almesberger.net>; from Werner.Almesberger@epfl.ch on Tue, Mar 27, 2001 at 10:43:21AM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 27, 2001 at 10:43:21AM +0200, Werner Almesberger escreveu:
> Arnaldo Carvalho de Melo wrote:
> > http://bazar.conectiva.com.br/~acme/TODO
> 
> BTW, I don't know if you're already interacting, but it seems to me that
> there are a lot of things on your list that look as if the MC project at
> Stanford ("CHECKER") could provide automated tests for them.

Yup, there has been some interaction in the past and I suggest that the
Stanford CHECKER people be subscribed to the kernel-janitors list or the
other way around, so that we can work more closely.

One thing is to find error patterns, and this is being done by the janitor
team and by any other interested people, other point is to go thru the
kernel sources and see where the patterns appear, and here the CHECKER is a
very important player if not the most important, and the other is to fix
the problems found, where active maintainers should do the work, despite
the fact that some are supposedly maintained (listed in MAINTAINERS or in
the kernel sources) some aren't, there are even drivers listed as
maintained but the maintainers don't even have the hardware anymore, and
new maintainers should appear or the janitors should do the work.

- Arnaldo
