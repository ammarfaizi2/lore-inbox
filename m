Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280931AbRKYQvr>; Sun, 25 Nov 2001 11:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKYQvi>; Sun, 25 Nov 2001 11:51:38 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30736 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280931AbRKYQvb>;
	Sun, 25 Nov 2001 11:51:31 -0500
Date: Sun, 25 Nov 2001 14:51:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Wayne.Brown@altec.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.0
Message-ID: <20011125145128.B1706@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Wayne.Brown@altec.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <86256B0F.0053E736.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86256B0F.0053E736.00@smtpnotes.altec.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 25, 2001 at 09:16:17AM -0600, Wayne.Brown@altec.com escreveu:
> 
> 
> Thanks.  I had hoped the version number was the only change, but wanted to be
> sure.  I'll be keeping just one source tree for both 2.4.x and 2.5.x and
> switching between the versions by applying and reversing patches as needed, so
> it's important that my copy of the source stay *exactly* in sync with Linus'

But keep in mind that this is only the fork point, from now on more and
more things will diverge and patches for one will not necessarily apply to
both trees.

> copy (otherwise I've have just altered the version in the Makefile myself).
> With the help of your patch I've just built both 2.4.16-pre1 and 2.5.1-pre1 from
> the same 2.4.15 source, which is what I wanted.
