Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTJ0WBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTJ0WBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:01:09 -0500
Received: from mout1.freenet.de ([194.97.50.132]:38861 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263609AbTJ0WBC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:01:02 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Yaoping Ruan <yruan@CS.Princeton.EDU>
Subject: Re: /proc/cpuinfo & top
Date: Mon, 27 Oct 2003 23:00:58 +0100
User-Agent: KMail/1.5.4
References: <5.1.0.14.2.20031022014409.00bd4aa0@hesiod> <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
In-Reply-To: <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310272300.59774.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 27 October 2003 22:31, Yaoping Ruan wrote:
> Hi,

Hi,

> I compiled 2.4.21 kernel with SMP and High-MEM enabled on a dual-CPU box,
> but surprised to see there're 4 CPUs in /proc/cpuinfo and top. But
> /proc/cpuinfo is correct if SMP is disable during kernel configuration.
> Did anybody experience this before?

Is it a dual HT system? Two HyperThreaded CPUs should become
4 virtual CPUs.

> Many thanks in advance
>
> - Yaoping Ruan

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/nZWaoxoigfggmSgRAuKKAJ4pKhyPIsnpk1u03mfBHODY2Z4KnwCfVcPH
VpyrfLhpspF0jdsaOAdvy7I=
=cLMb
-----END PGP SIGNATURE-----

