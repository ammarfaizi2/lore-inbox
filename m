Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbRFODYX>; Thu, 14 Jun 2001 23:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264202AbRFODYN>; Thu, 14 Jun 2001 23:24:13 -0400
Received: from 1-084.ctame701-2.telepar.net.br ([200.181.138.84]:5616 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S264196AbRFODXx>; Thu, 14 Jun 2001 23:23:53 -0400
Date: Fri, 15 Jun 2001 00:23:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rich.Liu@ite.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to patch driver into kernel
Message-ID: <20010615002351.D922@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rich.Liu@ite.com.tw, linux-kernel@vger.kernel.org
In-Reply-To: <412C066DD818D3118D4300805FD4667902090BD4@ITEMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <412C066DD818D3118D4300805FD4667902090BD4@ITEMAIL>; from Rich.Liu@ite.com.tw on Fri, Jun 15, 2001 at 11:09:13AM +0800
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2001 at 11:09:13AM +0800, Rich.Liu@ite.com.tw escreveu:
> hi:
>      I write a serial driver for linux , and have a personal test . I went
> to patch this driver into kernel 
> but I don't know how to contact serial.c author ......
> can any one help me ?

Look at MAINTAINERS in your kernel source tree, after a quick look I got:

8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
P:      Theodore Ts'o
M:      tytso@mit.edu
L:      linux-serial@vger.kernel.org
W:      http://serial.sourceforge.net
S:      Maintained

But you can also send the patch here if its small, for peer review.

- Arnaldo
