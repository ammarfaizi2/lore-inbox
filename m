Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSLWBjA>; Sun, 22 Dec 2002 20:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSLWBjA>; Sun, 22 Dec 2002 20:39:00 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:4480 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S265767AbSLWBjA> convert rfc822-to-8bit; Sun, 22 Dec 2002 20:39:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] scheduler tunables with contest - starvation_limit
Date: Mon, 23 Dec 2002 12:48:34 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200212201048.52690.conman@kolivas.net> <1040605610.2127.3.camel@icbm>
In-Reply-To: <1040605610.2127.3.camel@icbm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212231248.41958.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Thu, 2002-12-19 at 18:48, Con Kolivas wrote:
>> osdl, contest, tunable - starvation limit on 2.5.52-mm1
>
>Con, curiously, what is this OSDL hardware like?
>
>One thing I always liked about your Contest runs were you did them on
>your home machine, which was presumably fairly run-of-the-mill so we
>could keep an eye on the low-end desktop machines.

Forgot to mention I've been doing the scheduler tunables in smp mode just so 
it wouldnt take me too long to get results. I have no doubt the signal to 
noise ratio is greater in the uniprocessor results though.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+BmtyF6dfvkL3i1gRAq6wAJ9M1DlPK8JL5RaEbaOOcA6z+KhmZwCcDn+W
MUDPF6uqNGyQ8FRtWyr07B4=
=6oDv
-----END PGP SIGNATURE-----
