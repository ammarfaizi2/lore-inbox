Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293755AbSCKOEN>; Mon, 11 Mar 2002 09:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293751AbSCKOEE>; Mon, 11 Mar 2002 09:04:04 -0500
Received: from pat.uio.no ([129.240.130.16]:16303 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S293753AbSCKODx>;
	Mon, 11 Mar 2002 09:03:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15500.47425.28346.417278@charged.uio.no>
Date: Mon, 11 Mar 2002 15:03:45 +0100
To: Oleg Drokin <green@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <15500.47144.705329.809604@charged.uio.no>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020311154852.3981c188.skraw@ithnet.com>
	<20020311165140.A1839@namesys.com>
	<15500.47144.705329.809604@charged.uio.no>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > In any case, any occurence of an ESTALE error *must* first have
     > originated from the server. The client itself cannot determine
     > that a filehandle is stale.

BTW: a tcpdump would prove this...

Cheers,
  Trond
