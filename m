Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJPKLj>; Tue, 16 Oct 2001 06:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275861AbRJPKLa>; Tue, 16 Oct 2001 06:11:30 -0400
Received: from ns.etm.at ([212.88.180.5]:36875 "EHLO etm.at")
	by vger.kernel.org with ESMTP id <S274875AbRJPKLW>;
	Tue, 16 Oct 2001 06:11:22 -0400
Message-Id: <01Oct16.121213cest.117125@fwetm.etm.at>
From: "Stanislav Meduna" <stano@meduna.org>
To: "Kevin Krieser" <kkrieser_list@footballmail.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <NDBBLFLJADKDMBPPNBALAEHFGAAA.kkrieser_list@footballmail.com>
Subject: Re: USB stability - possibly printer related
Date: Tue, 16 Oct 2001 12:11:38 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Msmail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> One thing I have noticed is that, with the 2.4 kernels, my
> system doesn't like sharing IRQs as well as the 2.2 kernels.
> So you may want to see what devices share interrupts with
> your USB controller, and move the cards if necessary.

For the record: in my setup the USB controller has its own interrupt.

ide2 shares one with the ISDN card (Elsa Quickstep PCI) - I had
no problems with this in several months I am using this setup.

Regards
-- 
                                                Stano


