Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTK1HFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 02:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTK1HFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 02:05:31 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:936 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262048AbTK1HF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 02:05:28 -0500
Date: Fri, 28 Nov 2003 16:05:02 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: Hp/Compaq Fibre HBA
To: Danny Brow <fms@istop.com>
Cc: Kernel-Maillist <linux-kernel@vger.kernel.org>
Message-id: <013901c3b57d$f3fa1c20$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-2022-jp"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <20031126110558.16044.qmail@web13906.mail.yahoo.com>
 <016501c3b4d5$aa4b2130$2987110a@lsd.css.fujitsu.com>
 <1069949135.24875.11.camel@zeus.fullmotionsolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danny,

> This is all the information on the card.
> 
> Tachyon
> HPFC-5000c/3.0
> L2A0729
> 
> &
> 
> NEC
> Compaq 194789-002
> UPD65806GD-071
> 9733PU003

UPD65806 is a gate array.
http://www.necel.com/cgi-bin/nesdis/o003_e.cgi?article=UPD65806

HHBA-5000A uses Compaq original bus bridge chip.
So, you can't use "drivers/net/fc" driver.


Hironobu Ishii.

