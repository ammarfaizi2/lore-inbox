Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRCLAOR>; Sun, 11 Mar 2001 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRCLAOH>; Sun, 11 Mar 2001 19:14:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129270AbRCLAOD>; Sun, 11 Mar 2001 19:14:03 -0500
Subject: Re: About DC-315U scsi driver
To: kurt@garloff.de (Kurt Garloff)
Date: Mon, 12 Mar 2001 00:15:42 +0000 (GMT)
Cc: cwz@aic.ee.ndhu.edu.tw (³¯¤ý®i),
        linux-kernel@vger.kernel.org (Linux kernel list),
        linux-scsi@vger.kernel.org (Linux SCSI list)
In-Reply-To: <20010312004401.H2697@garloff.casa-etp.nl> from "Kurt Garloff" at Mar 12, 2001 12:44:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cG01-0000vN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > when I burn CDRs. Some files burned is different from the origin at HD.
> > I use 2.2.17 with Tekram's driver,and nothing is wrong.
> 
> Indeed; people report more problems on 2.4 kernels than on 2.2 kernels. I
> currently have no clue why.

2.4 causes longer continuous I/O requests to be sent to the drive for one


