Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313632AbSDPPo6>; Tue, 16 Apr 2002 11:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDPPo5>; Tue, 16 Apr 2002 11:44:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29957 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313632AbSDPPo4>; Tue, 16 Apr 2002 11:44:56 -0400
Subject: Re: Compiling ALSA with 2.5.7
To: Thomas.Downing@ipc.com (Downing, Thomas)
Date: Tue, 16 Apr 2002 17:02:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A92EE23DE@exnanycmbx4.ipc.com> from "Downing, Thomas" at Apr 16, 2002 11:35:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVPi-0000F1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The correct replacement of virt_to_bus( ) to pci_map_*( ) is not 
> obvious to a newbie from a look at pci.h.

Have a look at the DMA-Mapping.txt documentation file. Its not a trivial
replacement but its maybe one to have a go at. 

Alan
