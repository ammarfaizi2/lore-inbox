Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265746AbSKFPwi>; Wed, 6 Nov 2002 10:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265747AbSKFPwi>; Wed, 6 Nov 2002 10:52:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39436 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265746AbSKFPwh>;
	Wed, 6 Nov 2002 10:52:37 -0500
Message-ID: <3DC93C34.40201@pobox.com>
Date: Wed, 06 Nov 2002 10:58:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xmb <xmb@kick.sytes.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: initramfs in 2.5.46 wont compile
References: <2147483647.1036601487@[192.168.1.2]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xmb wrote:
> Yo,
> 
> was trying to compile 2.5.46 fresh from source on my ppc machine, and 
> initramfs gives me an err (in make bzImage):
> 
> make -f scripts/Makefile.build obj=arch/ppc/kernel 
> arch/ppc/kernel/asm-offsets.s



ppc arch support for initramfs needs to be added...

