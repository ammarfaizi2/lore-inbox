Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRIOAMN>; Fri, 14 Sep 2001 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIOAMF>; Fri, 14 Sep 2001 20:12:05 -0400
Received: from cr213096-a.rchrd1.on.wave.home.com ([24.157.75.69]:19206 "EHLO
	cr213096-a.rchrd1.on.wave.home.com") by vger.kernel.org with ESMTP
	id <S271597AbRIOALy>; Fri, 14 Sep 2001 20:11:54 -0400
Message-ID: <3BA29CC2.8030008@phobos.sharif.edu>
Date: Fri, 14 Sep 2001 20:11:46 -0400
From: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.19 i686; en-US; rv:0.9.1) Gecko/20010610
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA26542.21DC105A@MissionCriticalLinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Can you generate a cdrom image which has that problem (and less than 50 
megs) in order
to test?
thanks,
Masoud
Bruce Blinn wrote:

>Hello:
>
>I sent the following message to the kernel newbies mailing list, and it
>was suggested that I send it to the kernel mailing list.  I am not a
>subscriber of this mailing list, so I would appreciate any replies being
>sent to me directly.
>
>-----------------------
>
>I have found that after upgrading from 2.2.19 to 2.4.6, I can no longer
>read CD-ROMs that were created under Windows.  Since they work fine on
>2.2.19, I assume there is some configuration option that has changed,
>but I did not see anything that looked suspicious.
>
>I can mount the CD and list the files on it, but when I try to access
>one of the files on it, I get an IO error.
>
>When I created the disk on Windows, I selected the option to "Organize
>the disc so it can be read in most standard CD-ROM drives...".  On
>Linux, I selected the kernel options for ISO 9660 and the Joliet
>extensions.
>
>Does anyone have any ideas about what I am doing wrong?
>
>Thanks,
>Bruce
>



