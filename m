Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRB1Jed>; Wed, 28 Feb 2001 04:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRB1JeX>; Wed, 28 Feb 2001 04:34:23 -0500
Received: from limdns2.unilim.fr ([164.81.1.5]:23638 "EHLO limdns2.unilim.fr")
	by vger.kernel.org with ESMTP id <S129155AbRB1JeH> convert rfc822-to-8bit;
	Wed, 28 Feb 2001 04:34:07 -0500
Message-Id: <4.2.0.58.20010228103140.00bafab0@pop.unilim.fr>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.0.58 
Date: Wed, 28 Feb 2001 10:34:03 +0100
To: linux-kernel@vger.kernel.org
From: Nicolas Viers - SCI Limoges <viers@unilim.fr>
Subject: Pb with 3c 575 Fast ethernet Pcmcia
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how to make my 3c575Ct works with Mandrake 7.2
When i start linux the network seems to be ok (ifconfig)
But the pc doesn't speak with the network.
I have the erreor message:
interrupt posted but not delivered -- IRQ blocked by another device ?

I change the irq with no result.

I try to start linux with "noapic" and no result.
This ethernet card works with Windows 95 on the same pc.

Do you have an idea ?

Thaks a lot

____________________________________________________________

Nicolas Viers               |  Service Commun Informatique
Mél: viers@unilim.fr        |  123, avenue Albert Thomas
                             |     87060 Limoges cedex
Tel: 05-55-45-77-09         |  Fax: 05-55-45-75-95
		  http://www.unilim.fr/sci
____________________________________________________________
