Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbRDUPiH>; Sat, 21 Apr 2001 11:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132697AbRDUPh5>; Sat, 21 Apr 2001 11:37:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132698AbRDUPhv>; Sat, 21 Apr 2001 11:37:51 -0400
Subject: Re: Inspiron 8000 does not resume after suspend
To: woodst@cs.tu-berlin.de (Daniel Dorau)
Date: Sat, 21 Apr 2001 16:39:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010421145133.A419@woodstock.home.xxx> from "Daniel Dorau" at Apr 21, 2001 02:51:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qzTh-0003rZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With an older BIOS version that I upgraded because of a newer
> ATI BIOS needed, it woke up execpt some PCI bridge(?) that I 
> could re-activate with a setpci-script that I found in a
> linux-kernel archive. So I think the problem is the same as
> before.
> Is there any way to fix that? I would really like to use
> PM on my notebook.

It depends what is not being reactivatdd. You could try building a kernel
with serial console and debugging out of a serial port. I played with the 8000
a bit when fixing up stuff in RH7.1 and gave up.

Alan

