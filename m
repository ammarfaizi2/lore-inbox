Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUHBRMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUHBRMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUHBRMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:12:15 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:5309 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266661AbUHBRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:11:12 -0400
Date: Mon, 2 Aug 2004 14:11:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/cycx_x25.c:189: warning: conflicting types for built-in function 'log2'
Message-ID: <20040802171148.GA2393@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0408010225180.2660@dragon.hygekrogen.localhost> <20040731173832.451d4e9e.akpm@osdl.org> <Pine.LNX.4.60.0408010246090.2660@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408010246090.2660@dragon.hygekrogen.localhost>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.011046, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 01, 2004 at 02:53:06AM +0200, Jesper Juhl escreveu:
> On Sat, 31 Jul 2004, Andrew Morton wrote:
> 
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >>
> >
> > Your patches get random rejects.
> >
> >> Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
> >
> > Probably because of the format=flowed braindamage.
> >
> Ouch, sorry about that, I recently upgraded my pine version to 4.60 and 
> was unaware that from that version and forward pine generates flowed text 
> by default. I'll get that fixed up at once.
> 
> 
> > I fixed this one up.
> >
> Thank you.  

Thanks for the patch
