Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSGaMZl>; Wed, 31 Jul 2002 08:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGaMZl>; Wed, 31 Jul 2002 08:25:41 -0400
Received: from mail.grafix.nl ([217.67.234.56]:17305 "EHLO mail.grafix-is.com")
	by vger.kernel.org with ESMTP id <S317997AbSGaMZl>;
	Wed, 31 Jul 2002 08:25:41 -0400
Message-ID: <004701c2388e$39e25180$3100000a@michiel>
Reply-To: "Michiel Klaver" <michiel@grafix.nl>
From: "Michiel Klaver" <michiel@grafix.nl>
To: <linux-kernel@vger.kernel.org>
Subject: RE: sending pkt_too_big to self
Date: Wed, 31 Jul 2002 14:31:35 +0200
Organization: GrafiX Internet B.V.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered the same problem with some 2.4.xx kernels. Sometimes FTP or
MySQL connections 'hang' and the message "sending pkt_too_big to self"
appears in the kernel log files.

When you take a search at google:
http://www.google.nl/search?q=%22sending+pkt_too_big+to+self%22 you will
find more people with this problem.

Has someone an explanation for this?

Michiel Klaver
GrafiX Internet B.V.
The Netherlands
michiel@grafix.nl


