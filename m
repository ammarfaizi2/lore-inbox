Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRFELUB>; Tue, 5 Jun 2001 07:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263964AbRFELTv>; Tue, 5 Jun 2001 07:19:51 -0400
Received: from springer254.asv.de ([194.64.254.254]:54021 "EHLO
	springer254.asv.de") by vger.kernel.org with ESMTP
	id <S263963AbRFELTh>; Tue, 5 Jun 2001 07:19:37 -0400
Message-ID: <026001c0edb0$fd4a5cf0$7400a8c0@dukat.cb.de>
From: "Ingo T. Storm" <it@lapavoni.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 <-> 2.4.5-ac5 tcp too slow (false alarm)
Date: Tue, 5 Jun 2001 13:16:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Right now I am compiling 2.4.5 on the clients to verify that it's an
>2.2 vs 2.4 issue.

It wasn't 2.4 vs. 2.2 but the tulip driver. Swapped it for a dual
eepro100 and  geth 8MB/s (tbench 4) now.

Ingo


