Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSL1XJe>; Sat, 28 Dec 2002 18:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbSL1XJd>; Sat, 28 Dec 2002 18:09:33 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:59922 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266443AbSL1XJC>; Sat, 28 Dec 2002 18:09:02 -0500
Date: Sat, 28 Dec 2002 21:16:50 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.5.53 : modules_install warnings
Message-ID: <20021228231650.GE27758@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
References: <Pine.LNX.4.44.0212281758230.839-100000@linux-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212281758230.839-100000@linux-dev>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 28, 2002 at 06:01:55PM -0500, Frank Davis escreveu:
> Hello all,
>   I received the following warnings while a 'make modules_install'. It 
> looks like there are a few more locking changes that need to be made. :)

A few? do a make allmodconfig and you rethink your statement 8)

- Arnaldo
