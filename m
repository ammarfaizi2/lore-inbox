Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbRHBCcO>; Wed, 1 Aug 2001 22:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbRHBCcE>; Wed, 1 Aug 2001 22:32:04 -0400
Received: from da01a-srvutl01.arcommunications.net ([216.168.64.3]:54172 "HELO
	smtp1.arcip.net") by vger.kernel.org with SMTP id <S268045AbRHBCbu>;
	Wed, 1 Aug 2001 22:31:50 -0400
Message-ID: <3B685B3C.A40AD2C@gxt.com>
Date: Wed, 01 Aug 2001 21:40:44 +0200
From: Mohamed DOLLIAZAL <mhd@gxt.com>
Organization: GX-Technology
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 ext2fs corruption status
In-Reply-To: <E15S6E0-00084e-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > It may be that Red Hat has already released a new kernel RPM since that
> > time, or maybe you need to compile a new kernel.
>
> The official VIA workaround fix is now in 2.4.6ac5 and 2.4.7ac*. The fixes
> in the older kernels were mostly going to do the job but I dont know if they
> were perfect for all cases
>
> The -ac kernel tree also contains important fixes that avoid DMA timeouts
> potentially causing disk corruption by forgetting to write sectors

Hi Alan,

   I'am sorry I forgot to mention that the filesystem corruption happened on
SCSI disks.  I guess there is no DMA on the SCSI disks.
   Do you think that the VIA fixes that are included in the 2.4.6ac5 kernel or
above may solve my problem.

Thanks for your help,

Mohamed.

