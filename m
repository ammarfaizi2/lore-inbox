Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310402AbSCGQwU>; Thu, 7 Mar 2002 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310403AbSCGQwN>; Thu, 7 Mar 2002 11:52:13 -0500
Received: from tangens.hometree.net ([212.34.181.34]:61071 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S310402AbSCGQv6>; Thu, 7 Mar 2002 11:51:58 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Date: Thu, 7 Mar 2002 16:51:56 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a685rc$v4$1@forge.intermeta.de>
In-Reply-To: <Pine.GSO.4.21.0203061424190.14695-100000@vervain.sonytel.be> <Pine.LNX.4.21.0203061525160.6899-100000@serv> <20020306090011.G15303@work.bitmover.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1015519916 31658 212.34.181.4 (7 Mar 2002 16:51:56 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 7 Mar 2002 16:51:56 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>	# extract all the patches from 2.5.0 onward.
>	bk prs -hrv2.5.0.. |  while read x
>	do	bk export -tpatch -r$i > ~ftp/patches/patch-$i
>	done

[henning@henning henning]$ bk prs -hrv2.5.0.. |  while read x
while: Expression Syntax.

You obviously just _underlined_ the point, Larry.

	Regards
		Henning

It's tcsh; before you ask.
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
