Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbSKQLfn>; Sun, 17 Nov 2002 06:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSKQLfn>; Sun, 17 Nov 2002 06:35:43 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:32524 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267470AbSKQLfn>; Sun, 17 Nov 2002 06:35:43 -0500
Date: Sun, 17 Nov 2002 09:42:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Tarkan Erimer <tarkane@solmaz.com.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: Compile error on 2.5.47 with TCPMSS support enabled
Message-ID: <20021117114230.GA28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Tarkan Erimer <tarkane@solmaz.com.tr>, linux-kernel@vger.kernel.org
References: <200211162115.04614.tarkane@solmaz.com.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211162115.04614.tarkane@solmaz.com.tr>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 09:15:04PM +0200, Tarkan Erimer escreveu:
> 
> Hi,
> 
> I try to compile 2.5.47 kernel with "TCPMSS target support" enabled in 
> "Netfilter configuration". But, when I did "make bzImage", I got an error
> message, which is, attached to this mail with "error.out" file. 
> 
> When I disabled "TCPMSS target support", kernel built successfully.

Fixed in current BK tree...

- Arnaldo
