Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTBGEyQ>; Thu, 6 Feb 2003 23:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBGEyQ>; Thu, 6 Feb 2003 23:54:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20499 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267693AbTBGEyQ>;
	Thu, 6 Feb 2003 23:54:16 -0500
Date: Thu, 6 Feb 2003 20:59:19 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, hpa@zytor.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: [RFC] klibc for 2.5.59 bk
Message-ID: <20030207045919.GA30526@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
now working.  I've created a patch against Linus's latest bk tree and
put it at:
	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz
(I can't get to kernel.org right now, sorry)
and there's a bk tree at:
	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5

I'd really like to send this to Linus now, but I'm going to be away
from email for about a week, so I'll wait will I get back.  If anyone
has any issues with this patch, please let me know.

thanks,

greg k-h
