Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUBFSDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUBFSDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:03:35 -0500
Received: from mout0.freenet.de ([194.97.50.131]:13198 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S265389AbUBFSDd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:03:33 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Fri, 6 Feb 2004 19:03:20 +0100
User-Agent: KMail/1.6.50
References: <4022BC15.4090502@wanadoo.es> <200402062112.32212.chakkerz@optusnet.com.au> <20040206175248.GE26093@fs.tum.de>
In-Reply-To: <20040206175248.GE26093@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Unger <chakkerz@optusnet.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402061903.31039.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 06 February 2004 18:52, you wrote:
> gcc 2.95 is usually a good choice.
> 
> But although it's unlikely, it would eliminate one possible problem if 
> someone would check whether the problem still exists with a kernel that 
> is compiled with e.g. gcc 3.3.2 .

The problem occured for me a few days ago with a gcc 3.3.2
compiled linux-2.6.2-rc2

> cu
> Adrian
> 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAI9bxFGK1OIvVOP4RAgRmAKDP8XNSp+cfwmU6KGrffZ0Q8MbkgQCgue7w
FFUX287kLwBk15juYW1l8RI=
=SXlV
-----END PGP SIGNATURE-----
