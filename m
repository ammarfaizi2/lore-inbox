Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318347AbSG3Q4U>; Tue, 30 Jul 2002 12:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318350AbSG3Q4T>; Tue, 30 Jul 2002 12:56:19 -0400
Received: from mout0.freenet.de ([194.97.50.131]:37294 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318347AbSG3Q4T>;
	Tue, 30 Jul 2002 12:56:19 -0400
Message-ID: <010201c237ea$7d338ac0$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Michael Kerrisk" <m.kerrisk@gmx.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
Date: Tue, 30 Jul 2002 18:59:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What causes the delay of a few seconds following each of the connect()s
>in excess of backlog?

And to engage my brain a bit - I assume the delay is to prevent flooding!  
What detemines the length of the delay>

Cheers

Michael


