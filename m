Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSKVVPf>; Fri, 22 Nov 2002 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSKVVPf>; Fri, 22 Nov 2002 16:15:35 -0500
Received: from mailc.telia.com ([194.22.190.4]:9176 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S264659AbSKVVPe>;
	Fri, 22 Nov 2002 16:15:34 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <000e01c2926d$533a1080$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Brian Murphy" <brian@murphy.dk>, <linux-kernel@vger.kernel.org>
Cc: "Matt Domsch" <Matt_Domsch@Dell.com>
References: <IGEFJKJNHJDCBKALBJLLIEDMFIAA.joakim.tjernlund@lumentis.se> <3DDE92B2.20605@murphy.dk>
Subject: Re: [PATCH 2.5] crc32 static initialization
Date: Fri, 22 Nov 2002 22:22:56 +0100
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

> Joakim Tjernlund wrote:
> 
> >Hi Brian
> >
> >Would you please also add the CRC32 patch I sent you earlier?
> >It is much faster.
> >
> >  
> >
> Can you test the attached patch - especially on a big endian system. It 
> should
> do the required thing, i.e. what you want and what I want :-) 
> simultaneously.

Yes, will test on PPC(BE system).  I am bit busy during the weekend, but I hope
to do it early next week. Thanks for adding my patch.

         Jocke
