Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbREFMjs>; Sun, 6 May 2001 08:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135658AbREFMji>; Sun, 6 May 2001 08:39:38 -0400
Received: from denise.shiny.it ([194.20.232.1]:23778 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S135655AbREFMja>;
	Sun, 6 May 2001 08:39:30 -0400
Message-ID: <3AF3E20D.94B62929@denise.shiny.it>
Date: Sat, 05 May 2001 13:20:45 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems even with 512 block size MOs
In-Reply-To: <15088.18199.487902.514295@hertz.ikp.physik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> recent 2.4 kernels have incredible bad performance for me when handling MO
> drives. Going back 2.2 shows better performance.

> Copying a 6.5 MByte file with cp returns nearly immediately on the
> commandline, but umount nearly takes forever. Maximum rate detected by
> xosview during umount was about 30 kByte.

I have this one:

  Vendor: FUJITSU   Model: MCD3130SS         Rev: 0020

and it works very well with 2.4. 2.2 kernel perform really badly because of
the famous merging problem.

> Are all my MO disks rotten? Are the MO drives broken? Are my SCSI adapters
> broken? Or is there a bug in the SCSI layer?

No probs here. I have an Adaptec SCSI card.

Bye.


