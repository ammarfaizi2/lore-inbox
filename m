Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269391AbRHWSPM>; Thu, 23 Aug 2001 14:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRHWSPD>; Thu, 23 Aug 2001 14:15:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4361 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269391AbRHWSOw>; Thu, 23 Aug 2001 14:14:52 -0400
Subject: Re: Athlon/3DNow write prefetch?
To: afranck@gmx.de (Andreas Franck)
Date: Thu, 23 Aug 2001 19:18:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01082320130001.21357@dg1kfa> from "Andreas Franck" at Aug 23, 2001 08:13:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zz3U-0004Id-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Athlon/3DNow prefetchw() implementation uses the `prefetch' assembler 
> instruction, which is in fact a read prefetch, while it should use the 
> `prefetchw' instruction, which is for write prefetch.

Yep
