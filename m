Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292969AbSB1AVj>; Wed, 27 Feb 2002 19:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSB1AUU>; Wed, 27 Feb 2002 19:20:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292969AbSB1AUG>; Wed, 27 Feb 2002 19:20:06 -0500
Subject: Re: Linux 2.4.19pre1-ac1
To: afranck@gmx.de (Andreas Franck)
Date: Thu, 28 Feb 2002 00:34:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), florin@iucha.net (Florin Iucha),
        linux-kernel@vger.kernel.org
In-Reply-To: <02022800441601.01097@dg1kfa> from "Andreas Franck" at Feb 28, 2002 01:13:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gEWj-0006aD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Will try this now, sounds possible - but does patch really use shared memory?
> I will try to narrow it down a bit. There also were some changes to 
> mm/memory.c between 2.4.18-rc2-ac2 and 2.4.18-ac1. Also a possibility?

Could be - as far as I can tell they are also in vanilla 2.4.18 (the
ptrace ones)

Alan
