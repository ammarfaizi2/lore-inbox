Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129607AbRBYTIW>; Sun, 25 Feb 2001 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRBYTIM>; Sun, 25 Feb 2001 14:08:12 -0500
Received: from mx.interplus.ro ([193.231.252.3]:26633 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S129607AbRBYTIB>;
	Sun, 25 Feb 2001 14:08:01 -0500
Message-ID: <3A995873.4939ED4A@interplus.ro>
Date: Sun, 25 Feb 2001 21:09:39 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac3 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: Siddharth Kashyap <kernel_i386@yahoo.com>
CC: lk <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect CD Drive speed
In-Reply-To: <20010225182123.66799.qmail@web12808.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Simple, our friends at No-name OEM Corporation ;) named that drive
"CDROM DRIVE 52X" in his ID string, a perfect OEM name that does not
involves any brand and looks good in windoze where the l/user see it in
system configuration as above.
	The hard reality is next, meaning the Linux driver determined "by
specific means" :) that the drive is at most "48X CD-ROM DRIVE w/128kb
buffer", THAT windozians will NOT see it.
	It happens a lot here in Romania also with crap chinese/taiwanese
drivers that doesn't carry any brand name and are bulk solded.
	Personally, I'll trust more a drive that say "Teac Corporation 32X"
than that no-name shit. IMMV.

			Mircea C.


> 

Siddharth Kashyap wrote:
> 
>  Hi all,
> 
>  I have 52X ATAPI/IDE internel cdrom dive. I am using
> 2.2.16 kernel. At the boot time I get the message:
> 
>   hdb: CDROM DRIVE 52X
> 
>  Then two lines later, i get the following message:
> 
>   hdb: 48X CD-ROM DRIVE w/128kb buffer
> 
>   Can someone tell me why am I getting these two
> different messages?
> 
>   Thanks,
>     Siddharth.
