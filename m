Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265583AbSKACFR>; Thu, 31 Oct 2002 21:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSKACFQ>; Thu, 31 Oct 2002 21:05:16 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:35856 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265583AbSKACFN>; Thu, 31 Oct 2002 21:05:13 -0500
Date: Thu, 31 Oct 2002 23:10:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021101021043.GE17128@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
	Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031170420.GA30193@opus.bloom.county>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini escreveu:
> In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about anything /
> everything which might want to be tuned up.  Then this becomes a truely
> useful set of options, since as Alan pointed out in one of the earlier
> CONFIG_TINY threads, his Athlon could benefit from some of these 'tiny'
> options too.

CONFIG_TINY would be just a way to enable all the CONFIG_FINE_TUNE_WHATEVER
options that reduce image size.

- Arnaldo
