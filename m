Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312532AbSDOASI>; Sun, 14 Apr 2002 20:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDOASH>; Sun, 14 Apr 2002 20:18:07 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:39433 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S312524AbSDOASG>;
	Sun, 14 Apr 2002 20:18:06 -0400
Date: Mon, 15 Apr 2002 02:03:28 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: ivan <ivan@es.usyd.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Leaking. Help!
In-Reply-To: <Pine.LNX.4.33.0204142204330.19694-100000@dipole.es.usyd.edu.au>
Message-ID: <Pine.LNX.3.96.1020415020052.6319B-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 14 Apr 2002, ivan wrote:

> Hi,
> 
> I have posted this to linux-mm list but it is a bit quite there, so I
> decided to try this one.
[...]
> 2) Is there a tool which I can use to log memory usage 

Perhaps memstat can help you. From the manpage:

       memstat - Identify what's using up virtual memory.

On my Debian it's in the memstat package, should be the same on RH.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPLoY1hETUsyL9vbiEQKPpgCfcqZ2VsfgktUIZHhU02dPAszca1QAnjUl
2e061Zo24OX/nV+NSrZQ1dEL
=MY4s
-----END PGP SIGNATURE-----

