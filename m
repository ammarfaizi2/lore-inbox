Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285188AbRL2RlS>; Sat, 29 Dec 2001 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285168AbRL2RlG>; Sat, 29 Dec 2001 12:41:06 -0500
Received: from net015s.hetnet.nl ([194.151.104.155]:57106 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S285114AbRL2Rkc>;
	Sat, 29 Dec 2001 12:40:32 -0500
Message-Id: <5.1.0.14.2.20011229182802.00a2c5f0@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 29 Dec 2001 18:29:32 +0100
To: Jeroen Vreeken <pe1rxq@amsat.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20011229001511.C278@jeroen.pe1rxq.ampr.org>
In-Reply-To: <E16K68F-00029E-00@the-village.bc.nu>
 <5.1.0.14.2.20011228213437.009d1190@pop.hetnet.nl>
 <E16K68F-00029E-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:15 29-12-01 +0100, Jeroen Vreeken wrote:
>However I have started to make a patch for ax25 to use sock_orphan, but
>recently we had some trouble with 2.4 kernels that might be related to my
>changes or the scc driver, so I am now looking at fixing that, as soon as
>that is sorted out I will submit a patch that fixes it the right way.

Okay, I'll wait for that. In the meantime your patch works for me (with BayCom and YAM modem).

Kind regards,

Henk.

