Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291463AbSBMJiy>; Wed, 13 Feb 2002 04:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291472AbSBMJip>; Wed, 13 Feb 2002 04:38:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291463AbSBMJid>;
	Wed, 13 Feb 2002 04:38:33 -0500
Date: Wed, 13 Feb 2002 01:36:44 -0800 (PST)
Message-Id: <20020213.013644.118972487.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: ac9410@bellsouth.net, alan@clueserver.org, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 sound module problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16avgO-0004j7-00@the-village.bc.nu>
In-Reply-To: <20020212.202233.102575669.davem@redhat.com>
	<E16avgO-0004j7-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Wed, 13 Feb 2002 09:26:32 +0000 (GMT)
   
   There are PCI drivers using the old sound code. Whether it matters is a 
   more complicated question as these devices use ISA DMA emulation or their
   own pseudo DMA functionality.
   
The sound layer PCI DMA stuff like a nice project for some kernel
janitors :-))

