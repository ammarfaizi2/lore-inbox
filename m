Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSGTE7r>; Sat, 20 Jul 2002 00:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSGTE7q>; Sat, 20 Jul 2002 00:59:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51980 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317363AbSGTE7q>; Sat, 20 Jul 2002 00:59:46 -0400
Date: Sat, 20 Jul 2002 02:02:33 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Impressions of IDE 98?
Message-ID: <20020720050233.GE4557@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2002 at 10:51:26PM -0600, Thunder from the hill escreveu:
> I don't have any IDE machines handy, and since these problems that IDE had 
> in the last days, I wonder what's become of it. Has anyone been so brave 
> as to try out 2.5.26 w/the included IDE (IDE 98)? How is it?

I've been using the current linus BK tree, which already has more than what
is in 2.5.26 in a dual pentium 100 machine with a buggy CMD640 machine without
problems up to now. 32 MB of memory, 16 MB of swap, old QUANTUM LPS210A:

 hda: 412110 sectors w/98KiB Cache, CHS=723/15/38

Did some light stress testing, swapping, etc, no problems up to now, and with
Rik's minimal rmap patch that is already at Linus BK tree. 8)

- Arnaldo
