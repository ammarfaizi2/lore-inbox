Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUGJO0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUGJO0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUGJO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:26:49 -0400
Received: from web20827.mail.yahoo.com ([216.136.227.166]:50778 "HELO
	web20827.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266257AbUGJO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:26:48 -0400
Message-ID: <20040710142647.73810.qmail@web20827.mail.yahoo.com>
Date: Sat, 10 Jul 2004 07:26:47 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: Re: Re: Need help in creating 8GB RAMDISK
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> What do you need this for?
> 
> Mostly it looks like you just need to use kmap,
> but...
> As other have pointed out ramfs is usually the
> better solution,
> and you don't need to code anything.
> 
> Or are you trying to use an 7GB initrd.  An
> interesting idea
> but that would take a little bootloader hacking to
> make work.

Actually I need 7GB RAMDISK to use with my Caching
Drive Project. I have to use RAMDISK of 7GB or more
for the Caching purpose. The Architecture is like Disk
Caching Disk (DCD), but here I hav to use RAMDISK. 

I created RAMDISK using physical address as I hav
reserved all RAM above 1GB for my RAMDISK, but I am
not able to create RAMDISK of 7GB as a single Drive. 

Is there any Idea regarding this ????

Fawad Lateef



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
