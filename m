Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSKGJSE>; Thu, 7 Nov 2002 04:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266429AbSKGJR7>; Thu, 7 Nov 2002 04:17:59 -0500
Received: from mail.hometree.net ([212.34.181.120]:19680 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266417AbSKGJQf>; Thu, 7 Nov 2002 04:16:35 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: build kernel for server farm
Date: Thu, 7 Nov 2002 09:23:13 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aqdbe1$jd4$1@forge.intermeta.de>
References: <1036620009.1332.12.camel@mattsworkstation>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036660993 8595 212.34.181.4 (7 Nov 2002 09:23:13 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 7 Nov 2002 09:23:13 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Simonsen <matt_lists@careercast.com> writes:

>Tips? Comments?

make rpm [1]

% rpm --install <your rpm>

[1] Either the genuine thing or the process of "go and build an rpm of
your kernel". YMMV.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
