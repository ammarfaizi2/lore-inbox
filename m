Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbTAWO0X>; Thu, 23 Jan 2003 09:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbTAWO0X>; Thu, 23 Jan 2003 09:26:23 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:22924 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S265247AbTAWO0W> convert rfc822-to-8bit; Thu, 23 Jan 2003 09:26:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Adam Voigt <adam@cryptocomm.com>,
       Santosh Kumar Cheekatmalla <pyara_indian@hotmail.com>
Subject: Re: Can any one please help me..
Date: Thu, 23 Jan 2003 15:35:20 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <F130l8HvNuSNGDQ6on70000056f@hotmail.com> <1043331674.1664.7.camel@beowulf.cryptocomm.com>
In-Reply-To: <1043331674.1664.7.camel@beowulf.cryptocomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301231535.20133.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 January 2003 15:21, Adam Voigt wrote:
> A. You must be logged in as root.
> B. Your device is /dev/hda for your first hard drive.
>
> Enjoy!
>


Hmm,

that might work, but when when the chipset is not supported we also see the 
the oppereation not permitted messages.
So Santosh, if you run hdparm as root and still get those messages, your 
chipset might not be suppported. Your /var/log/messages should give you more 
information about whats going on, especially the kernel-ide detection lines. 
Without further information about your mainboard and the kernel version you 
are using, all of this is only speculation.

Bernd
