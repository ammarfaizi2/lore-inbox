Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263976AbRFNDmG>; Wed, 13 Jun 2001 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263975AbRFNDlq>; Wed, 13 Jun 2001 23:41:46 -0400
Received: from 1-084.ctame701-2.telepar.net.br ([200.181.138.84]:254 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S263976AbRFNDlh>; Wed, 13 Jun 2001 23:41:37 -0400
Date: Thu, 14 Jun 2001 00:41:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: "Daniel" <ddickman@nyc.rr.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
Message-ID: <20010614004128.A8206@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	"Daniel" <ddickman@nyc.rr.com>,
	"Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <ddickman@nyc.rr.com> <200106140155.f5E1ts5X003318@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200106140155.f5E1ts5X003318@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Wed, Jun 13, 2001 at 09:55:54PM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 13, 2001 at 09:55:54PM -0400, Horst von Brand escreveu:
> "Daniel" <ddickman@nyc.rr.com> said:
> > I really think doing a clean up is worthwhile. Maybe while looking for stuff
> > to clean up we'll even be able to better comment the existing code. Any
> > other features people would like to get rid of? Any comments or suggestions?
> > I'd love to start a good discussion about this going so please send me your
> > 2 cents.
> 
> Try it, and come back with patches.

hey, the KJP needs volunteers to tackle this bug/cleanup list:

http://bazar.conectiva.com.br/~acme/TODO

More info available at http://kernel-janitor.sourceforge.net/, the Stanford
Checker also found bugs that have to be fixed (link provided in the KJP
page), please help.

As for what I want to get rid of? Bugs, getting rid of those would be
excellent ;)

- Arnaldo (the one that is porting a network stack to 2.4 that would warrant
           death penalty if Daniel was the judge ;) )
