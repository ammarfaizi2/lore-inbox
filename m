Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310403AbSCGRGA>; Thu, 7 Mar 2002 12:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310414AbSCGRFx>; Thu, 7 Mar 2002 12:05:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310403AbSCGRFi>; Thu, 7 Mar 2002 12:05:38 -0500
Subject: Re: [OOPS] Linux 2.2.21pre[23]
To: luca.montecchiani@teamfab.it (Luca Montecchiani)
Date: Thu, 7 Mar 2002 17:20:28 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C879E01.B2BFAFCD@teamfab.it> from "Luca Montecchiani" at Mar 07, 2002 06:06:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j1Z6-0002xf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You're right x86_serial_nr_setup() is c0278bc8
> while c0278bc1 didn't exist in my system.map sorry!

You always want the symbol before the number
