Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbRFNSZh>; Thu, 14 Jun 2001 14:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263782AbRFNSZ1>; Thu, 14 Jun 2001 14:25:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52369 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263669AbRFNSZN>;
	Thu, 14 Jun 2001 14:25:13 -0400
Message-ID: <3B290182.42DE3E1@mandrakesoft.com>
Date: Thu, 14 Jun 2001 14:25:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Mansfield <lkml@dm.ultramaster.com>,
        lkml <linux-kernel@vger.kernel.org>, jfs-discussion@oss.lotus.com
Subject: Re: severe FS corruption with 2.4.6-pre2 + IBM jfs 0.3.4 patch
In-Reply-To: <E15Abh0-000564-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > It's probably a JFS issue, but I thought I'd report this in case someone
> > is collecting and correlating filesystem corruption messages (Alan?).
> > Here is my sad story.
> 
> I get as far as 'using jfs' and delete them

Understandable but FWIW they have apparently passed a night of
stress-kernel (cerberus) testing on the latest jfs..

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
