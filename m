Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRLWE0p>; Sat, 22 Dec 2001 23:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRLWE0f>; Sat, 22 Dec 2001 23:26:35 -0500
Received: from mail.apptechsys.com ([207.14.35.131]:60307 "HELO
	mail.apptechsys.com") by vger.kernel.org with SMTP
	id <S283390AbRLWE0Z>; Sat, 22 Dec 2001 23:26:25 -0500
Date: Sat, 22 Dec 2001 20:26:24 -0800 (PST)
From: Jeremy Drake <jeremyd@apptechsys.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbol in nfsd.o kernel 2.4.17
In-Reply-To: <20011223020109.A19764@conectiva.com.br>
Message-ID: <Pine.LNX.4.33L2.0112222024380.21842-100000@eiger.apptechsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 22, 2001 at 07:49:55PM -0800, Jeremy Drake escreveu:
> > I am getting an undefined symbol in nfsd.o in kernel 2.4.17.  The message
> > is "/lib/modules/2.4.17/kernel/fs/nfsd/nfsd.o: unresolved symbol
> > nfsd_linkage".  Nfsd works fine when linked into the kernel.
>
> which gcc version are you using?
>
> - Arnaldo

gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)

