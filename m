Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136543AbREDW1o>; Fri, 4 May 2001 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136563AbREDW1f>; Fri, 4 May 2001 18:27:35 -0400
Received: from mail.mojomofo.com ([208.248.233.19]:14347 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S136543AbREDW1a>;
	Fri, 4 May 2001 18:27:30 -0400
Message-ID: <006e01c0d4e9$3c0bd210$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu>
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Date: Fri, 4 May 2001 18:26:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What still stands out is that exactly _zero_ people have reported the same
> problem with non VIA chipset Athlons.

This might be grasping at straws I remember VIA problem in the "good old
days" of Socket 7 with CPU/PCI Prefetches and especially Read-around-Write
settings that would cause issues like we're seeing with the Athlon
pre-fetches. This could be (total conjecture) related somehow to the
corruption bugs they are admitting to in the 686B although they are blaming
the SB Live now.



