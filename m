Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSFJS7j>; Mon, 10 Jun 2002 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSFJS7i>; Mon, 10 Jun 2002 14:59:38 -0400
Received: from horus.webmotion.com ([209.87.243.246]:49795 "EHLO
	horus.webmotion.ca") by vger.kernel.org with ESMTP
	id <S315779AbSFJS7g>; Mon, 10 Jun 2002 14:59:36 -0400
Message-ID: <3D04F704.5090202@bonin.ca>
Date: Mon, 10 Jun 2002 14:59:16 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: root@chaos.analogic.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <Pine.LNX.3.95.1020610141042.17451B-100000@chaos.analogic.com> <3D04EDC1.8010402@drugphish.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> Hi,
> 
>> I know there is support for "firewire" in the kernel. Is there
>> support for "firewire" disks? If so, how do I enable it?
> 
> 
> Yes, there is and it is attached to the SCSI layer via the sbp2 driver. 
> You need following set of modules to get it working:
> 
> scsi_mod, sd_mod, ohci1394, raw1394, ieee1394, sbp2

A lot of caddies that wrap hd's have started coming out and, as you may 
know, USB 2.0 supports 480mbps x-fer rate (ideal).  So it's pretty 
intreguing.

Does the SCSI layer via sbp2 provide functionality for USB 2.0 (EHCI) 
disks?


