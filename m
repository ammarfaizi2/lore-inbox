Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRIMQg7>; Thu, 13 Sep 2001 12:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271823AbRIMQgt>; Thu, 13 Sep 2001 12:36:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49670 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271798AbRIMQgb>;
	Thu, 13 Sep 2001 12:36:31 -0400
Date: Thu, 13 Sep 2001 13:36:53 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Kent Borg <kentborg@borg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Novell Client End?
Message-ID: <20010913133653.Z8509@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Kent Borg <kentborg@borg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010913123011.B23220@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010913123011.B23220@borg.org>; from kentborg@borg.org on Thu, Sep 13, 2001 at 12:30:11PM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 13, 2001 at 12:30:11PM -0400, Kent Borg escreveu:
> Has anyone ever done any Linux work on Novell protocols--but the
> client end?  (Specifically, for a printer?)

> (Anyone know they could write such a thing with ease?)

you mean nprint/rprint? That needs SPX and SPX is humm, unmaintained and
incomplete in Linux as of now, I plan to do some work on it in the future,
to have nprint/rprint working in Linux, docs are available at the Novell
site.

- Arnaldo
