Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbRB1POm>; Wed, 28 Feb 2001 10:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRB1POc>; Wed, 28 Feb 2001 10:14:32 -0500
Received: from 2-031.cwb-adsl.telepar.net.br ([200.193.161.31]:30962 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130211AbRB1POQ>; Wed, 28 Feb 2001 10:14:16 -0500
Date: Wed, 28 Feb 2001 10:35:14 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Holluby@conectiva.com.br,
        István <holluby@interware.hu>@conectiva.com.br
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mke2fs /dev/loop0
Message-ID: <20010228103514.F24856@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Holluby István <holluby@interware
	.hu>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0102281545120.1836-100000@cica.khb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.LNX.4.33.0102281545120.1836-100000@cica.khb.hu>; from isti@interware.hu on Wed, Feb 28, 2001 at 04:07:03PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 28, 2001 at 04:07:03PM +0100, Holluby István holluby@interware.hu escreveu:
> 	Hi!
> 
> This command hangs my system. It works for a 100K file, but it hangs my
> system, if the file is 470M. It does not matter, if the disk is SCSI or
> ide.
> 
> linux 2.4.2
> glibc-2.2.2
> gcc-2.95.2.1
> e2fs-1.19
> 
> With kernel 2.2.18, it works fine.

FAQ, try 2.4.2-acLATEST (now its ac6)
 
> ===============
> I also have some problem, with ncpfs. I am not quite sure, because I had to
> hack the source, to compile it, but the same hack works with 2.2.18.
> 
> If you have anything to tell, please mail me. I am not on the list.

I'm interested if this is directly related to IPX, Petr is the guy for
NCPfs, can you please send us more details about this problem? Hangs? Data
corruption? what?

- Arnaldo
