Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274576AbRITRiT>; Thu, 20 Sep 2001 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274577AbRITRiH>; Thu, 20 Sep 2001 13:38:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29964 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274576AbRITRiC>; Thu, 20 Sep 2001 13:38:02 -0400
Subject: Re: qlogic driver , 1Tbyte hard error
To: ehw@lanl.gov (Eric Weigle)
Date: Thu, 20 Sep 2001 18:43:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), nalabi@formail.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010920095056.A21993@lanl.gov> from "Eric Weigle" at Sep 20, 2001 09:50:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k7qr-0005iI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given the relatively low cost of disk space ($5000/terabyte and on up, see
> http://staff.sdsc.edu/its/terafile/), is this something that will be supported
> in the future?

2.5 Im sure

> If you point me in the right direction I'd be willing to look at this issue.

signed int overflow of 512 byte blocks

