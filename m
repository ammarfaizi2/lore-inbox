Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRKTW5t>; Tue, 20 Nov 2001 17:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281457AbRKTW5k>; Tue, 20 Nov 2001 17:57:40 -0500
Received: from 27-ZARA-X4.libre.retevision.es ([62.82.232.27]:39433 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S281103AbRKTW5d>;
	Tue, 20 Nov 2001 17:57:33 -0500
Message-ID: <3BFAE0FD.8010909@zaralinux.com>
Date: Wed, 21 Nov 2001 00:02:21 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: Sven Heinicke <sven@research.nj.nec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Heinicke wrote:

> I got tired at looking proc_misc.c to see what /proc/stat was
> reporting about.  So here is my noted patched into proc.txt about the
> /proc/stat file.  It's a patch off the 2.4.15-pre1 proc.txt, but it
> worked fine patching it into 2.4.15-pre4 kernel.  Between which I
> don't actually think proc.txt has changed.
> 
> 	   Sven
> 
> [snip]

>  Summary
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Hey I wrote the last update to this file about exactly one year ago, and 
I wrote it for the same reasons as you.

I needed some info about some files and fields in the proc tree, and the 
responses was 1) read proc.txt (seriously out of date) and 2) look at 
the source Luke.

So I also got tired of seeking & greping around the code and wrote a 
small update, nice to see someone updated it again.

P.D. It should be updated by the people who updates the interface, at 
least minimally, the name and meaning of the fields or where to look.

-- 
Jorge Nerin
<comandante@zaralinux.com>

