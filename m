Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRGXIpm>; Tue, 24 Jul 2001 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbRGXIpc>; Tue, 24 Jul 2001 04:45:32 -0400
Received: from staf.steva.nl ([213.84.5.97]:48398 "HELO charon.staf.steva.nl")
	by vger.kernel.org with SMTP id <S267148AbRGXIpR>;
	Tue, 24 Jul 2001 04:45:17 -0400
Message-ID: <000701bff54b$750ea6b0$140bc90a@delphi>
From: "Jordi Verwer" <jordiv@steva.nl>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Externally transparent routing
Date: Mon, 24 Jul 2000 10:45:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all,

To prevent my NAT-box from showing up on traceroutes I'd like to let it
route without decreasing the TTL. I was told that proxy arp also archieves
this, however I have no need for proxy arp per se and am also not completely
confident that that will do what I want. I also saw TTL decrease/increase
settings in the iptables mangling options, however I use 2.2 and would
rather not upgrade. So my question is: is this possible under 2.2 and if so,
how?

Thanks in advance,
Jordi Verwer

P.S.: Please send me a CC of your reply, as I am not subscibed.

