Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287991AbSAMMhZ>; Sun, 13 Jan 2002 07:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289165AbSAMMhO>; Sun, 13 Jan 2002 07:37:14 -0500
Received: from mons.uio.no ([129.240.130.14]:6641 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S287991AbSAMMhJ>;
	Sun, 13 Jan 2002 07:37:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15425.32621.987964.944902@charged.uio.no>
Date: Sun, 13 Jan 2002 13:37:01 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] some strangeness (at least) with linux-2.4.18-NFS_ALL patch
In-Reply-To: <20020112224046.4205F1433@shrek.lisa.de>
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
	<20020112170111.12E601431@shrek.lisa.de>
	<15424.33959.99237.666877@charged.uio.no>
	<20020112224046.4205F1433@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > client: Athlon 1.2, Asus Via KT133, 768 MB Linux version
     > 2.4.18-pre3 (hp@elfe) (gcc version 2.95.3 20010315 (SuSE)) #3
     > Sam Jan 12 21:26:40 CET 2002 mount opt:
     > rw,nodev,v3,rsize=4096,wsize=4096,soft,intr,udp,lock,addr=shrek

     > Any more ideas? What's wrong with my setup?

10 to 1 it's the 'soft' mount option.

Cheers,
   Trond
