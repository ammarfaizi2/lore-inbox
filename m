Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274469AbRITMnN>; Thu, 20 Sep 2001 08:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274466AbRITMnC>; Thu, 20 Sep 2001 08:43:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274467AbRITMmv>; Thu, 20 Sep 2001 08:42:51 -0400
Subject: Re: qlogic driver , 1Tbyte hard error
To: nalabi@formail.org
Date: Thu, 20 Sep 2001 13:47:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109200818.f8K8Iur02280@mail.wowlinux.com> from "Kim Yong Il" at Sep 20, 2001 05:19:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k3FD-0005E1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The maximum supported file system size under Linux 2.4 is just under 1Tb.
The scsi layer gets slightly confused a bit earlier with its printk messages
