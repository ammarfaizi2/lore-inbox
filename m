Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbRFAPqG>; Fri, 1 Jun 2001 11:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263596AbRFAPp4>; Fri, 1 Jun 2001 11:45:56 -0400
Received: from be02.imake.com ([151.200.87.11]:56844 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S263218AbRFAPpl>;
	Fri, 1 Jun 2001 11:45:41 -0400
Message-ID: <3B17B943.ABACDDA8@247media.com>
Date: Fri, 01 Jun 2001 11:48:20 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 VM
In-Reply-To: <E155bG5-0008AX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I have a 2.4.5-ac3 box with 1G RAM and 2.6G Swap....first time
developers hit apache/php/zendcache after reboot and it swapped to a stop.

I stop/restarted apache and it seems very happy...can't goto production like this tho :(

Alan Cox wrote:

> > My system has 128 Meg of Swap and RAM.
>
> Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> with 2.4.
>
> Marcelo is working to change that but right now you are running something
> explicitly explained as not going to work as you want
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com

Programming today is a race between software
engineers striving to build bigger and better
idiot-proof programs, and the Universe trying to
produce bigger and better idiots. So far, the
Universe is winning. - Rich Cook
---------------------------------------------------


