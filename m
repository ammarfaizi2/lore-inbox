Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbREQVp1>; Thu, 17 May 2001 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbREQVpS>; Thu, 17 May 2001 17:45:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3847 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262189AbREQVpG>; Thu, 17 May 2001 17:45:06 -0400
Subject: Re: Linux 2.4.4-ac10: Oops
To: greg@ulima.unil.ch (FAVRE Gregoire)
Date: Thu, 17 May 2001 22:41:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010517225232.A8072@ulima.unil.ch> from "FAVRE Gregoire" at May 17, 2001 10:52:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150VWd-0006Cz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SCSI subsystem driver Revision: 1.00
> PCI: Found IRQ 11 for device 00:0b.0
> Unable to handle kernel NULL pointer dereference at virtual address 0000000
> printing eip:

What scsi drivers do you have and which are on IRQ 11
