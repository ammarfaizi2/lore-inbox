Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTBGE4x>; Thu, 6 Feb 2003 23:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbTBGE4x>; Thu, 6 Feb 2003 23:56:53 -0500
Received: from terminus.zytor.com ([63.209.29.3]:64163 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267717AbTBGE4w>; Thu, 6 Feb 2003 23:56:52 -0500
Message-ID: <3E433EBC.5000202@zytor.com>
Date: Thu, 06 Feb 2003 21:06:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <20030207045919.GA30526@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Hi all,
> 
> Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
> now working.  I've created a patch against Linus's latest bk tree and
> put it at:
> 	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz
> (I can't get to kernel.org right now, sorry)
> and there's a bk tree at:
> 	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5
> 
> I'd really like to send this to Linus now, but I'm going to be away
> from email for about a week, so I'll wait will I get back.  If anyone
> has any issues with this patch, please let me know.
> 

That's good, that'll give me a chance to check through it.

What klibc is this based on?

	-hpa


