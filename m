Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262039AbRENBHl>; Sun, 13 May 2001 21:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbRENBHb>; Sun, 13 May 2001 21:07:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18953 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262041AbRENBHS>; Sun, 13 May 2001 21:07:18 -0400
Subject: Re: Adaptec RAID SCSI 2100S
To: jpabuyer@tecnoera.com (Juan Pablo Abuyeres)
Date: Mon, 14 May 2001 02:03:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105132017430.27901-100000@baltazar.tecnoera.com> from "Juan Pablo Abuyeres" at May 13, 2001 08:41:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z6m5-00079E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to make this card work under 2.4.4, but I couldn't find a patch
> anywhere to get it working under 2.4.x nor on 2.2.x. I tried with the I2O
> kernel support, but it didn't work, it only reported errors after a pretty
> long waiting :)

You need to 2.4.4ac8 or higher for dpt i2o_scsi and 2.4.4ac5 or so or higher
for dpt i2o_block

