Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282919AbRLWEBW>; Sat, 22 Dec 2001 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282962AbRLWEBM>; Sat, 22 Dec 2001 23:01:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17939 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282919AbRLWEBB>;
	Sat, 22 Dec 2001 23:01:01 -0500
Date: Sun, 23 Dec 2001 02:01:09 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeremy Drake <jeremyd@apptechsys.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbol in nfsd.o kernel 2.4.17
Message-ID: <20011223020109.A19764@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeremy Drake <jeremyd@apptechsys.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0112221937190.21842-100000@eiger.apptechsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0112221937190.21842-100000@eiger.apptechsys.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 22, 2001 at 07:49:55PM -0800, Jeremy Drake escreveu:
> I am getting an undefined symbol in nfsd.o in kernel 2.4.17.  The message
> is "/lib/modules/2.4.17/kernel/fs/nfsd/nfsd.o: unresolved symbol
> nfsd_linkage".  Nfsd works fine when linked into the kernel.

which gcc version are you using?

- Arnaldo
