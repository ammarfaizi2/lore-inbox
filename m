Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265159AbRF0A2C>; Tue, 26 Jun 2001 20:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265161AbRF0A1w>; Tue, 26 Jun 2001 20:27:52 -0400
Received: from mail.vibe.com ([208.206.144.37]:13952 "EHLO vibe.com")
	by vger.kernel.org with ESMTP id <S265159AbRF0A1k>;
	Tue, 26 Jun 2001 20:27:40 -0400
Message-ID: <002a01c0fe9f$ecc73fb0$6900a8c0@STUARTHAASW2K>
From: "Stuart Haas" <shaas@vibe.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.6 Pre 5 Not see all available RAM
Date: Tue, 26 Jun 2001 20:27:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2479.0005
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have discovered that while running 2.4.6pre5, the kernel does not see all
available RAM - I have 1GB and the kernel only sees ~899MB.  The stock
Redhat 7.1 kernel sees the full 1024MB.  Adding mem=1024M on boot does not
help either.

I'm running an IBM x340, dual 1GHz cpu.

Have I missed something?

Stuart



