Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSELLGd>; Sun, 12 May 2002 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSELLGc>; Sun, 12 May 2002 07:06:32 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:20721 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312498AbSELLGc>; Sun, 12 May 2002 07:06:32 -0400
Message-ID: <3CDE4CCD.99F5D0BE@wanadoo.fr>
Date: Sun, 12 May 2002 13:06:53 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-ac1 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8-ac2 does not compile
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've the following messages :

make[1]: Entering directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
/usr/bin/make -r -f .tmp_include_depends all
make[2]: Entering directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
make[2]: .tmp_include_depends: Aucun fichier ou répertoire de ce type
make[2]: *** No rule to make target `.tmp_include_depends'.  Stop.
make[2]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
make[1]: *** [.tmp_include_depends] Error 2
make[1]: Leaving directory `/usr/src/kernel-sources-2.4.19-pre8-ac2'
make: *** [stamp-build] Error 2

----------
Regards
	Jean-Luc
