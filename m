Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSH1Niy>; Wed, 28 Aug 2002 09:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSH1Niy>; Wed, 28 Aug 2002 09:38:54 -0400
Received: from mta.sara.nl ([145.100.16.144]:43215 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S318825AbSH1Nix>;
	Wed, 28 Aug 2002 09:38:53 -0400
Date: Wed, 28 Aug 2002 15:43:02 +0200
Subject: Re: [patch] SImple Topology API v0.3 (1/2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: <linux-kernel@vger.kernel.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <Pine.LNX.4.44.0208280711390.3234-100000@hawkeye.luckynet.adm>
Message-Id: <12A602D1-BA8C-11D6-A20D-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On woensdag, augustus 28, 2002, at 03:14 , Thunder from the hill wrote:

> Hi,
>
> On Tue, 27 Aug 2002, Pavel Machek wrote:
>>> -   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
>>> +   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
>>
>> Why not simply CONFIG_NUMA?
>
> Because NUMA is subordinate to X86, and another technology named NUMA
> might appear? Nano-uplinked micro-array... No Ugliness Munched Archive?
> Whatever...

Until we port Linux to SGI Origin 200/2000/3000 NUMA clusters....

And AFAIK there are more hw suppliers working on designing NUMA systems. 
All more
or less the same, and again all very different.

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9bNNxBIoCv9yTlOwRAtxNAJ42ZsWw5mcYsgJySLoLxdarIFsGHQCgmfoH
dw0bN9YSjpeX9HhfC3RO9g8=
=J8cK
-----END PGP SIGNATURE-----

