Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRK1Sio>; Wed, 28 Nov 2001 13:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRK1Sie>; Wed, 28 Nov 2001 13:38:34 -0500
Received: from mail.spylog.com ([194.67.35.220]:65158 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S279261AbRK1SiX>;
	Wed, 28 Nov 2001 13:38:23 -0500
Date: Wed, 28 Nov 2001 21:38:12 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.17-pre1
Message-ID: <20011128213811.A20085@spylog.ru>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.21.0111281340210.15491-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111281340210.15491-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.23i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo Tosatti,


Please, don`t forget change PATCHLEVEL/SUBLEVEL/EXTRAVERSION.

 
> Ok, 2.4.17-pre1 is out. Still going to the mirrors though, so please wait
> a while if you haven't found a copy on your local mirror. 
> 
> 
> pre1:
> 
> - Change USB maintainer 			(Greg Kroah-Hartman)
> - Speeling fix for rd.c				(From Ralf Baechle's tree)
> - Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
> - Add buggy 440GX to broken pirq blacklist 	(Arjan Van de Ven)
> - Add new entry to Sound blaster ISAPNP list	(Arjan Van de Ven)
> - Remove crap character from Configure.help	(Niels Kristian Bech Jensen)
> - Backout erroneous change to lookup_exec_domain (Christoph Hellwig)
> - Update osst sound driver to 1.65		(Willem Riede)
> - Fix i810 sound driver problems		(Andris Pavenis)
> - Add AF_LLC define in network headers		(Arnaldo Carvalho de Melo)
> - block_size cleanup on some SCSI drivers	(Erik Andersen)
> - Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
>   modules
> - Add ->show_options() to super_ops and 
>   implement NFS method				(Alexander Viro)
> - Updated i8k driver				(Massimo Dal Zoto)
> - devfs update  				(Richard Gooch)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.
