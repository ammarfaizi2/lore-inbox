Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSHZT3d>; Mon, 26 Aug 2002 15:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSHZT3d>; Mon, 26 Aug 2002 15:29:33 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:5893 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S318285AbSHZT3b>; Mon, 26 Aug 2002 15:29:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: henrique <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: PCI weird behavior
Date: Mon, 26 Aug 2002 16:35:34 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208261635.34765.henrique@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to load the pc300.o driver on a 2.5.13 kernel. The load fail cause 
the driver is receiving a "struct pci_dev" with irq=0.
The weird is that the file /proc/pci shows irq=9 for the same board.

Does anyone know what is happened ?

Thanks in advance
regards
Henrique

