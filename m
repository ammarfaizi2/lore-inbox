Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317475AbSF1U3C>; Fri, 28 Jun 2002 16:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSF1U3B>; Fri, 28 Jun 2002 16:29:01 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:30694
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S317475AbSF1U27> convert rfc822-to-8bit; Fri, 28 Jun 2002 16:28:59 -0400
Message-ID: <20020628203120.23875.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: ide-cs not releasing interrupt line
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 28 Jun 2002 23:31:20 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am using 2.4.18 and am having trouble
with ide-cs not releasing the reserved interrupt
when the pcmcia board is ejected.

As I am using this to read my CompactFlash cards
and have only one interrupt to spare it means that
I have to reboot between every CF-cartridge,
not very Linux:ish.......

Any hints ?
Bug in ide-cs or in the cardmanger stuff ?

BRGDS


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


