Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSLHAsh>; Sat, 7 Dec 2002 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSLHAsh>; Sat, 7 Dec 2002 19:48:37 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:43445 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265037AbSLHAsg>; Sat, 7 Dec 2002 19:48:36 -0500
Subject: Re: [PATCH 2.4.20-BK] Needed patch to build ide-scsi with new IDE
	-ac merge
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200212080021.31324.m.c.p@wolk-project.de>
References: <200212072055.55152.m.c.p@wolk-project.de>
	<20021207231841.GC3183@werewolf.able.es> 
	<200212080021.31324.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:32:02 +0000
Message-Id: <1039311122.27923.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 23:21, Marc-Christian Petersen wrote:
> On Sunday 08 December 2002 00:18, J.A. Magallon wrote:
> 
> Hi J.A.,
> 
> > Ejem, does this mean that Andre's ide is going into 2.4.21-pre1 ?
> > ;))))
> finally!!!!!!!!!

Yes though various bits seem to have vanished in the submission
(system.h bits and ide-scsi). Davem has some follow up bits I need to
apply (the new IDE broke some weird 64bit bigendian platform that he
supports 8))

