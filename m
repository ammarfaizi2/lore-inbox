Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHZNuF>; Sun, 26 Aug 2001 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271007AbRHZNtp>; Sun, 26 Aug 2001 09:49:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64004 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269641AbRHZNti>;
	Sun, 26 Aug 2001 09:49:38 -0400
Date: Sun, 26 Aug 2001 10:49:44 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Soete Joel <joel.soete@freebel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NTFS support broken?
Message-ID: <20010826104944.A1385@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Soete Joel <joel.soete@freebel.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3B88F7F7.26BAC09B@freebel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B88F7F7.26BAC09B@freebel.net>; from joel.soete@freebel.net on Sun, Aug 26, 2001 at 01:21:59PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 26, 2001 at 01:21:59PM +0000, Soete Joel escreveu:
> Not sure it is a bug because of my install between potato and woody But
> when I recompile kernel 2.4.9 I had to add into linux/fs/ntfs/unistr.h:
> #include <linux/kernel.h> otherwise building the kernel complains because
> of lack of min function reference.

yeah, you're the 1000th person to tell this in this list, no offense, just
a fact, thanks anyway 8)

- Arnaldo

