Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278768AbRKHXNZ>; Thu, 8 Nov 2001 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRKHXNP>; Thu, 8 Nov 2001 18:13:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28947 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278768AbRKHXNB>; Thu, 8 Nov 2001 18:13:01 -0500
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Thu, 8 Nov 2001 23:19:36 +0000 (GMT)
Cc: lkml-frank@unternet.org (Frank de Lange), linux-kernel@vger.kernel.org
In-Reply-To: <89EA9194B5B@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Nov 08, 2001 09:08:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161ySO-00014Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and for which I can say that they works (== do not use VMware with
> 2.4.13-ac8, vmmon will not restore correct %cr2 value under some
> conditions, use -ac7 until it is clear whether non-standard %cr2 usage 
> is going to stay or not).

%cr2 doesnt work out. Don't worry about it

Alan
