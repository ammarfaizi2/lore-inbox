Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310940AbSCVLBD>; Fri, 22 Mar 2002 06:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311194AbSCVLAy>; Fri, 22 Mar 2002 06:00:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54535 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311171AbSCVLAr>; Fri, 22 Mar 2002 06:00:47 -0500
Message-ID: <3C9B0E88.70305@evision-ventures.com>
Date: Fri, 22 Mar 2002 11:59:20 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7, IDE, 'handler not null', 'kernel timer added twice'
In-Reply-To: <Pine.LNX.4.44.0203212207190.1580-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

> 
> 
> name			value		min		max		mode
> ----			-----		---		---		----
> acoustic                0               0               254             rw
> address                 0               0               2               rw
> bios_cyl                2495            0               65535           rw
> bios_head               255             0               255             rw
> bios_sect               63              0               63              rw
> bswap                   0               0               1               r
> current_speed           0               0               69              rw
> failures                0               0               65535           rw
> ide_scsi                0               0               1               rw
> init_speed              0               0               69              rw
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> lun                     0               0               7               rw
> max_failures            1               0               65535           rw
> multcount               16              0               16              rw
> nice1                   1               0               1               rw

Please try to set this nice1 stuff to 0 I would be glad
to know whatever this helps.

