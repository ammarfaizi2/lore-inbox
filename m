Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271675AbRHUNu4>; Tue, 21 Aug 2001 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271670AbRHUNuq>; Tue, 21 Aug 2001 09:50:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25873 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271667AbRHUNui>; Tue, 21 Aug 2001 09:50:38 -0400
Subject: Re: On Network Drivers......
To: vvgkrishna_78@yahoo.com (Venu Gopal Krishna Vemula)
Date: Tue, 21 Aug 2001 14:53:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <no.id> from "Venu Gopal Krishna Vemula" at Aug 21, 2001 03:11:04 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZByU-0007qv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> information related to the Network driver(in which
> multiple layers has to develop internally)  in
> Internet, but i could not found any source code or
> information in Internet.

How strange. The kernel source code is definitely on the internet, and
definitely contains drivers that implement internal layering - 
nrdev, shaper, the sync cards, isdn
