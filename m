Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285634AbRLVAdH>; Fri, 21 Dec 2001 19:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286123AbRLVAc5>; Fri, 21 Dec 2001 19:32:57 -0500
Received: from isis.telemach.net ([213.143.65.10]:22020 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S285936AbRLVAcu>;
	Fri, 21 Dec 2001 19:32:50 -0500
Message-ID: <001101c18a80$bd5202c0$41448fd5@telemach.net>
From: "Grega Fajdiga" <Gregor.Fajdiga@telemach.net>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112211259570.1091-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Problems with ATA hard disk(s)
Date: Sat, 22 Dec 2001 01:36:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

> 
> please read the FAQ.
I will 
> I'm guessing you've failed to set the relevant ide-related CONFIG_
> settings.  you definitely want the piix driver, and almost certainly
> also all the yes-really-use-dma-by-default ones.

Thank you, this indeed solved my problems.

Regards,
Grega Fajdiga

