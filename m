Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSFRWCZ>; Tue, 18 Jun 2002 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSFRWCY>; Tue, 18 Jun 2002 18:02:24 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:11251 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317648AbSFRWCF>;
	Tue, 18 Jun 2002 18:02:05 -0400
Date: Tue, 18 Jun 2002 15:02:06 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.22 broke kernel modular Pcmcia ?
Message-ID: <20020618150206.A7868@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I had a quick look in the archive and didn't find a report of
this problem :
--------------------------------
Starting PCMCIA services: /lib/modules/2.5.22/kernel/drivers/pcmcia/pcmcia_core.o: unresolved symbol pci_bus_type
--------------------------------
	Sorry if it's a duplicate...

	Jean
