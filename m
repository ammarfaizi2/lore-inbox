Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRFFKIe>; Wed, 6 Jun 2001 06:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbRFFKIY>; Wed, 6 Jun 2001 06:08:24 -0400
Received: from www.teaparty.net ([216.235.253.180]:6406 "EHLO www.teaparty.net")
	by vger.kernel.org with ESMTP id <S261547AbRFFKIN> convert rfc822-to-8bit;
	Wed, 6 Jun 2001 06:08:13 -0400
Date: Wed, 6 Jun 2001 11:08:10 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10106061101510.12097-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Dr S.M. Huen wrote:

> On Wed, 6 Jun 2001, Sean Hunter wrote:
> 
> > 
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> > 
> 
> Do I understand you correctly?
> ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> drives.

Not the point. It is an absolute pig to have to allocate extra swap just
because extra memory was added. You might not have a bay free. You might
not have the space knocking around to allocate as swap. It's not about the
money, it's about adaptability. 2.2 was perfectly happy before, why this
giant leap backwards? If I quadruple the memory in my laptop to 512Mb, do
I have to carve up my partitions just to get an extra 768Mb of swap? Or
must I turn off swap completely? What if you are working on a device where
everything is at a premium, both permamanent storage and memory, but you
do have a little to spare as swap?

It just seems like an overly onerous restriction.

-- 
The time for action is past!  Now is the time for senseless bickering.

