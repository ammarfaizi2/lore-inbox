Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbRGJQrY>; Tue, 10 Jul 2001 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbRGJQrP>; Tue, 10 Jul 2001 12:47:15 -0400
Received: from ns.suse.de ([213.95.15.193]:5380 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266652AbRGJQrI>;
	Tue, 10 Jul 2001 12:47:08 -0400
Date: Tue, 10 Jul 2001 18:47:09 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: John Clemens <john@deater.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: BIOS, Duron4 specifics...
In-Reply-To: <Pine.LNX.4.33.0107101222560.13575-100000@pianoman.cluster.toy>
Message-ID: <Pine.LNX.4.30.0107101837460.11256-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, John Clemens wrote:

> Actually, CPUID reports Family 6, Model 6, Rev2, which corellates directly
> to Athlon4/MP (Model 6) processors.

*nod*

> make me wonder if it's really a neutered Athlon4.  Besides, I though the
> origional mobile durons (T-bird core, model 3) didn't even support
> powernow...?

That was my belief also. It appears you have a new type of Duron.
I was unaware of this stepping, which makes me even more curious
to see your x86info -a output :)

> FYI: This is an HP 5430 notebook.  Duron 850.
> http://notebooks.hp-at-home.com/products/notebooks/overview.php?modelNumber=n5430

Neat. I'm expecting this to be new style (Athlon 4) PowerNow rather than
the K6 style PowerNOW. I'll look into this some more.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

