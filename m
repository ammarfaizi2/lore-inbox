Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274196AbRISVSz>; Wed, 19 Sep 2001 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274197AbRISVSp>; Wed, 19 Sep 2001 17:18:45 -0400
Received: from mail.mojomofo.com ([208.248.233.19]:12042 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S274196AbRISVSd>;
	Wed, 19 Sep 2001 17:18:33 -0400
Message-ID: <007001c14150$adcd0c10$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15jlpW-0003QP-00@the-village.bc.nu>
Subject: Re: Re[2]: [PATCH] VIA bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 17:18:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been busy working on other things, and being ill. I've not yet
pursued
> it with them

A minor nit I have with the patch is that it printk's out "Stomping the
Athlon bug", which in actuality is more likely a VIA bug because the
symptoms don't show up in other Althon based chipsets..



