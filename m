Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287675AbRLaW4Q>; Mon, 31 Dec 2001 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287677AbRLaWz7>; Mon, 31 Dec 2001 17:55:59 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:51986 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287675AbRLaWzv>;
	Mon, 31 Dec 2001 17:55:51 -0500
Date: Mon, 31 Dec 2001 20:55:52 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011231205552.A17089@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16K1fn-0001Ky-00@the-village.bc.nu> <200112312251.fBVMpNws032221@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112312251.fBVMpNws032221@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 31, 2001 at 07:51:23PM -0300, Horst von Brand escreveu:
> Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> > Something like:
> > 
> > 	find $TOPDIR -name "*.cf" -exec cat {} \; > Configure.help 
> 
> Make that:
> 
>      cat `find $TOPDIR -name "*.cf"` > Configure.help #;-)

whatever is faster, do you have trustable benchmark numbers? ;)

Yes, its a joke, have a nice 2002 all!

- Arnaldo
