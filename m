Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDKPeY>; Wed, 11 Apr 2001 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRDKPeP>; Wed, 11 Apr 2001 11:34:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132606AbRDKPeB>; Wed, 11 Apr 2001 11:34:01 -0400
Subject: Re: Bug in Kernel 2.4
To: landes@informatik.tu-muenchen.de (Tobias Landes)
Date: Wed, 11 Apr 2001 16:36:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041116233700.04302@r093165> from "Tobias Landes" at Apr 11, 2001 04:23:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nMfG-0006uF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe there is a bug in Linux Kernel 4.2. I tried Kernels 2.4.2 and 2.4.0 
> with my german SuSE-Distribution (7.1).
> The problem occurs with my SCSI MO drive. while it works fine with Kernel 
> 2.2.18 on the same machine and distribution, the behaviour with the newer 

SCSI M/O drives with 2K media are currently broken on 2.4 kernels. Bug
reports to linux-scsi@vger.kernel.org
