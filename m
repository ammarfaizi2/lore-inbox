Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbRFDSHt>; Mon, 4 Jun 2001 14:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264363AbRFDSHr>; Mon, 4 Jun 2001 14:07:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264235AbRFDSCU>; Mon, 4 Jun 2001 14:02:20 -0400
Subject: Re: Linux 2.4.5-ac7
To: trini@kernel.crashing.org (Tom Rini)
Date: Mon, 4 Jun 2001 18:59:25 +0100 (BST)
Cc: green@linuxhacker.ru (Oleg Drokin), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010604105600.D18033@opus.bloom.county> from "Tom Rini" at Jun 04, 2001 10:56:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156ydR-0005hH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried replying to this yesterday and it didn't get through, so..
> All of the MPC8xx chips can have a USB controller as well (albiet not OHCI
> or UHCI) and none of them have PCI either.

Ok I will change a future -ac to check PCI for OHCI/UHCI and then check 
'any host controller' for the devices
