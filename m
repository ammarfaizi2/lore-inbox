Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317929AbSGWEBf>; Tue, 23 Jul 2002 00:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317940AbSGWEBf>; Tue, 23 Jul 2002 00:01:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56582 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317929AbSGWEBf>; Tue, 23 Jul 2002 00:01:35 -0400
Date: Mon, 22 Jul 2002 22:04:37 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.COM>, linux-kernel@vger.kernel.org
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP
Message-ID: <20020723010437.GC2292@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.COM>,
	linux-kernel@vger.kernel.org
References: <20020722.195749.34129476.davem@redhat.com> <200207230356.HAA15253@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207230356.HAA15253@sex.inr.ac.ru>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 23, 2002 at 07:56:39AM +0400, kuznet@ms2.inr.ac.ru escreveu:
> Second, I never understood what is the problem with SIGURG.
> That's why it lives untouched.

Andi once described it to me and recently he described it to jamesm that
has done work on this area, but I think he is busy now and haven't had a
chance to finish, James?

- Arnaldo
