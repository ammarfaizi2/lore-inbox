Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSL3Gqg>; Mon, 30 Dec 2002 01:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSL3Gqg>; Mon, 30 Dec 2002 01:46:36 -0500
Received: from tag.witbe.net ([81.88.96.48]:35591 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266840AbSL3Gqf>;
	Mon, 30 Dec 2002 01:46:35 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'J.A. Magallon'" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.4.20
Date: Mon, 30 Dec 2002 07:54:55 +0100
Message-ID: <004f01c2afd0$5ceba280$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20021229221340.GA2259@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Tired of keeping copy of the kernel .config file, I decided 
> to create 
> > a kernel patch to have a /proc/config/config.gz
> 
> Why people does not read the archives before doing anything ?
> 

Maybe because they consider that there is not only one way to do
things... ;-)

OK, you don't like mine, no problem. I'm just expecting this 
functionnality in the kernel, not MY solution.

On a technical basis, I prefer to have a solution that is using
full compression from gzip rather than relying on a set of keyword
that will need to be updated with kernel dev and growth.

But, I'm second...

Regards,
Paul

