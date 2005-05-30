Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVE3MJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVE3MJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVE3MJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:09:09 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:57737 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261494AbVE3MJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:09:06 -0400
Message-ID: <002d01c56517$c5b60220$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
References: <20050529.135257.98862077.davem@davemloft.net><200505292138.j4TLcrJ28536@mail.macqel.be><20050529.145509.82051753.davem@davemloft.net><20050529195245.33f36253.akpm@osdl.org> <m14qclxbbh.fsf@muc.de>
Subject: Re: PATCH : ppp + big-endian = kernel crash
Date: Mon, 30 May 2005 09:01:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Andi Kleen" <ak@muc.de>
>
> An 68000 cannot, but 68010+ can. Are there really that many 68000 users
> left?

Desktop? Probably very few.  Probably a lot who don't even know they are
though - using things like the MC68SEC000.

The 16 bit external bus 68K variants are popular embedded processors.

