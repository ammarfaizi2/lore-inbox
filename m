Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318238AbSGQH4R>; Wed, 17 Jul 2002 03:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318239AbSGQH4Q>; Wed, 17 Jul 2002 03:56:16 -0400
Received: from gate.in-addr.de ([212.8.193.158]:54290 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318238AbSGQH4Q>;
	Wed, 17 Jul 2002 03:56:16 -0400
Date: Wed, 17 Jul 2002 10:00:37 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Zack Weinberg <zack@codesourcery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717080037.GA28190@marowsky-bree.de>
References: <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020717001032.GI358@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020717001032.GI358@codesourcery.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-16T17:10:32,
   Zack Weinberg <zack@codesourcery.com> said:

> Therefore, if you've checked the return value of fsync, there's no
> point in checking the subsequent close; and if you don't care to call
> fsync, the close return value is useless since it isn't guaranteed to
> detect anything.

There is _always_ a point in checking a return value of non void functions.

EOD.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

