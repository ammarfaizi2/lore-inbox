Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVHINwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVHINwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVHINwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:52:36 -0400
Received: from smtpout.mac.com ([17.250.248.45]:8939 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964774AbVHINwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:52:35 -0400
In-Reply-To: <42F872E3.3050106@scram.de>
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com> <1123528018.15269.44.camel@mindpipe> <20050808232957.GR4006@stusta.de> <42F872E3.3050106@scram.de>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, Lee Revell <rlrevell@joe-job.com>,
       abonilla@linuxwireless.org, "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Wireless support
Date: Tue, 9 Aug 2005 09:52:27 -0400
To: Jochen Friedrich <jochen@scram.de>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 9, 2005, at 05:09:55, Jochen Friedrich wrote:
> Third, both ndiswrapper and binary-only drivers only work on one  
> platform.
>
> E.g. broadcom has a binary-only driver for their WLAN card on  
> Linux, but
> only for mipsel (wrt54g).
>
> On Alpha or PowerPC, most WLAN equipment doesn't work under Linux,  
> at all.

Definitely.  I want my Airport Extreme to work!  Many users of the  
BCM4301
chip can get it to work (kinda) with Linux via ndiswrapper, but that  
means
they are much less likely to participate in any kind of reverse  
engineering
effort, even if it's just testing a new driver.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


