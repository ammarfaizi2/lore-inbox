Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271644AbRIGJaW>; Fri, 7 Sep 2001 05:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRIGJaN>; Fri, 7 Sep 2001 05:30:13 -0400
Received: from tangens.hometree.net ([212.34.181.34]:27289 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271644AbRIGJ36>; Fri, 7 Sep 2001 05:29:58 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Date: Fri, 7 Sep 2001 09:30:18 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9na43a$dk$1@forge.intermeta.de>
In-Reply-To: <20010906203646.A11741@gruyere.muc.suse.de> <20010906185124.42C37BC06C@spike.porcupine.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 999855018 26852 212.34.181.4 (7 Sep 2001 09:30:18 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 7 Sep 2001 09:30:18 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wietse@porcupine.org (Wietse Venema) writes:

>It's not portable as you may believe.

>    [root@redhat52 /root]# man rtnetlink
>    No manual entry for rtnetlink

% cd /home/distribution/RedHat-5.2/i386/
% ls -la kernel*
-r--r--r--    1 root     root      2216232 Oct 14  1998 kernel-2.0.36-0.7.i386.rpm
-r--r--r--    1 root     root       536848 Oct 14  1998 kernel-headers-2.0.36-0.7.i386.rpm
-r--r--r--    1 root     root        94694 Oct 14  1998 kernel-ibcs-2.0.36-0.7.i386.rpm
-r--r--r--    1 root     root       320370 Oct 14  1998 kernel-pcmcia-cs-2.0.36-0.7.i386.rpm
-r--r--r--    1 root     root      9625252 Oct 14  1998 kernel-source-2.0.36-0.7.i386.rpm

You don't _WANT_ to listen, do you? Andi told you many times, that
this is an Linux 2.1+ API. RH 5.2 is a 2.0 distribution. Of course,
there is no man page in it for this. It's almost three years
old. There are from this particular vendor, _FIVE_ newer distributions. 
What do you want to tell us? That you're living in the past?

Please stop constructing cases. Linux did move on slightly in the last
three years. Maybe some other OSes didn't.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
