Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbSKUQrd>; Thu, 21 Nov 2002 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSKUQrd>; Thu, 21 Nov 2002 11:47:33 -0500
Received: from mail.hometree.net ([212.34.181.120]:9364 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266848AbSKUQrc>; Thu, 21 Nov 2002 11:47:32 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [RFC/CFT] Separate obj/src dir
Date: Thu, 21 Nov 2002 16:54:38 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <arj34e$ffb$1@forge.intermeta.de>
References: <20021119202931.GA15161@mars.ravnborg.org> <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037897678 18715 212.34.181.4 (21 Nov 2002 16:54:38 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 21 Nov 2002 16:54:38 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

>Hmmm. If your source is located on a read-only file-system, you
>can't modify it. You are therefore doomed to use only "known working"

You modify it by other means than open()/read()/write()/close()

	Regards
		Henning


-- 

"In einem Abwägungsprozess, wollen wir weiter regieren, hat sich die
SPD und die Bundesregierung und auch der Bundesfinanzminister fürs
Weiterregieren entschieden und gegen die Ehrlichkeit" -- Oswald
Metzger, Bündnis '90/Die Grünen, 12.11.2002

-- 
Henning Schmiedehausen     "Interpol und Deutsche Bank, FBI und
hps@intermeta.de            Scotland Yard, Flensburg und das BKA
henning@forge.franken.de    haben unsere Daten da." -- Kraftwerk, 1981
