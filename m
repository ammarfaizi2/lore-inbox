Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSFDP2h>; Tue, 4 Jun 2002 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSFDP2g>; Tue, 4 Jun 2002 11:28:36 -0400
Received: from [212.176.239.134] ([212.176.239.134]:49038 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S313628AbSFDP2f>; Tue, 4 Jun 2002 11:28:35 -0400
Message-ID: <000901c20bdc$76642360$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: <linux-kernel@vger.kernel.org>
Subject: linux 2.4.19-preX IDE bugs
Date: Tue, 4 Jun 2002 19:28:21 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17FGEQ-0002mw-00*FjYWDNe./z2* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few days ago I wrote about ide & raid0 bugs in 2.4.19-pre8-ac5 and below
(plain 2.4.18 just trashes fs in a few hours)... Then I was asked about my
hardware configuration & then was .... ignored silently. Does it mean that
nobody cares about ide support in Linux kernel?!

Could someone bring light on what's wrong with promise IDE & ultra ata-100
hdds??? (It was working under 2.4.7)

PS: right now I moved mailspool & oracle redo logs (located on raw devices)
out of ide-raid0... & I don't see error messages in logs not because ide
driver works, but because of significally reduced IO... OS w/o working ide
driver
is a real enjoyment.


