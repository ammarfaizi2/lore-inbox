Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292655AbSBQA4b>; Sat, 16 Feb 2002 19:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292656AbSBQA4V>; Sat, 16 Feb 2002 19:56:21 -0500
Received: from 200-171-175-119.dsl.telesp.net.br ([200.171.175.119]:2564 "EHLO
	redtalon.wolves.com.br") by vger.kernel.org with ESMTP
	id <S292655AbSBQA4O> convert rfc822-to-8bit; Sat, 16 Feb 2002 19:56:14 -0500
Date: Thu, 14 Feb 2002 17:00:12 -0200 (BRST)
From: wolvie_cobain <wolvie@punkass.com>
X-X-Sender: <wolvie@redtalon.wolves.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: compilie problem
Message-ID: <Pine.LNX.4.33.0202141657280.1925-100000@redtalon.wolves.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i get the 2.5.4 kernel source but when i try o run make dep it get this
error.

-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep
scripts/mkdep.c
In file included from /usr/include/bits/posix1_lim.h:126,
                 from /usr/include/limits.h:144,
                 from
/usr/lib/gcc-lib/i386-slackware-linux/2.95.3/include/limits.h:117,
                 from
/usr/lib/gcc-lib/i386-slackware-linux/2.95.3/include/syslimits.h:7,
                 from
/usr/lib/gcc-lib/i386-slackware-linux/2.95.3/include/limits.h:11,
                 from scripts/mkdep.c:35:
/usr/include/bits/local_lim.h:36: linux/limits.h: No such file or
directory
make: *** [scripts/mkdep] Error 1

looks that are something missing here but i can't find it..
thanks..


"Nos tambem podemos trazer as coisas de volta.Dizem q somos o sonho de uma raca
carniceira e talvez seja verdade, mas se nos acreditarmos e sonharmos podemos
mudar o mundo. Nós podemos sonha-lo de novo"
"Sonho de mil gatos"
-------------------------------------------------------------------------------
                /"\
                \ /  CAMPANHA DA FITA ASCII - CONTRA MAIL HTML
                 X   ASCII RIBBON CAMPAIGN - AGAINST HTML MAIL
                / \
-------------------------------------------------------------------------------
				linux user #106516
				ICQ 	   #46105730

