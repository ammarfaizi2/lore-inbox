Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSELLJg>; Sun, 12 May 2002 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSELLJf>; Sun, 12 May 2002 07:09:35 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:8711 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312526AbSELLJe>; Sun, 12 May 2002 07:09:34 -0400
Date: Sun, 12 May 2002 13:09:32 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac2 does not compile
Message-ID: <20020512110932.GC3749@louise.pinerecords.com>
In-Reply-To: <3CDE4CCD.99F5D0BE@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1 day, 4:41)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>, May-12 2002, Sun, 13:06 +0200]
> Hi !
> I've the following messages :
> 
> make[1]: Entering directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include scripts/split-include.c
> scripts/split-include include/linux/autoconf.h include/config
> /usr/bin/make -r -f .tmp_include_depends all
> make[2]: Entering directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
> make[2]: .tmp_include_depends: Aucun fichier ou répertoire de ce type
> make[2]: *** No rule to make target `.tmp_include_depends'.  Stop.
> make[2]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
> make[1]: *** [.tmp_include_depends] Error 2
> make[1]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
> make: *** [stamp-build] Error 2


Look up the patch posted earlier today by Keith Owens.

T.
