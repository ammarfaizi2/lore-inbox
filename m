Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283223AbRLWCo7>; Sat, 22 Dec 2001 21:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283265AbRLWCoj>; Sat, 22 Dec 2001 21:44:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:60944 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283223AbRLWCod>;
	Sat, 22 Dec 2001 21:44:33 -0500
Date: Sun, 23 Dec 2001 00:44:34 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: sfr@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg ?
Message-ID: <20011223004434.A19313@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, sfr@gmx.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011222083457.GA666@asterix> <20011222.155713.84363957.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011222.155713.84363957.davem@redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 22, 2001 at 03:57:13PM -0800, David S. Miller escreveu:
> What compiler are you using to build these kernels?  To be honest
> the assertion you have triggered ought to be impossible and this is
> the first report I've ever seen of it triggering.

IIRC he said he (or another guy with the same problem) was using gcc
3.0.something available in Red Hat rawhide.

- Arnaldo
