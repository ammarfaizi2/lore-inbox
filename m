Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313347AbSC2Kuk>; Fri, 29 Mar 2002 05:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313434AbSC2Kua>; Fri, 29 Mar 2002 05:50:30 -0500
Received: from tangens.hometree.net ([212.34.181.34]:48356 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S313347AbSC2KuX>; Fri, 29 Mar 2002 05:50:23 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bkbits.net down
Date: Fri, 29 Mar 2002 10:50:22 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a81gte$hrj$1@forge.intermeta.de>
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com> <20020327222738.B16149@work.bitmover.com> <20020328112252.F22352@work.bitmover.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1017399022 21929 212.34.181.4 (29 Mar 2002 10:50:22 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 29 Mar 2002 10:50:22 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>The drive has bad blocks and when it hits them it goes into retry la la land,
>so I won't know which data is bad until I hit the bad blocks.

You've learned now the hard way why integrity checks in an application
will never be able to replace things like backups or RAID systems. 
Maybe you want to reread the flamewar^Wthread from some time ago with
your new knowledge.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
