Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSKWXMD>; Sat, 23 Nov 2002 18:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSKWXMD>; Sat, 23 Nov 2002 18:12:03 -0500
Received: from mailc.telia.com ([194.22.190.4]:35799 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S265828AbSKWXMC>;
	Sat, 23 Nov 2002 18:12:02 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <003201c29346$c80d3de0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Brian Murphy" <brian@murphy.dk>, <linux-kernel@vger.kernel.org>
References: <IGEFJKJNHJDCBKALBJLLEEEEFIAA.joakim.tjernlund@lumentis.se> <3DDFC044.30701@murphy.dk>
Subject: Re: [PATCH 2.5] crc32 static initialization
Date: Sun, 24 Nov 2002 00:19:33 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you send me a patch? I just used the original patch you sent me 
> which uses
> crc32table_le in crc32_be.

Oops, my mistake. I see that you have fixed this already. 
I am testing you new path as a write this looks good so far.

       Jocke

