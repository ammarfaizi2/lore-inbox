Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbULPRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbULPRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULPRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:38:26 -0500
Received: from web26505.mail.ukl.yahoo.com ([217.146.176.42]:54207 "HELO
	web26505.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261436AbULPRiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:38:12 -0500
Message-ID: <20041216173811.7697.qmail@web26505.mail.ukl.yahoo.com>
Date: Thu, 16 Dec 2004 17:38:11 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: 3TB disk hassles
To: Tomas Carnecky <tom@dbservice.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41C1C2AD.90902@dbservice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom...

 --- Tomas Carnecky <tom@dbservice.com> wrote: 
> I had a GUID partition table (GPT) on my system (x86, normal 
> mainboard/BIOS etc) and it worked fine. I didn't need a separate boot
> disk. I used grub as the boot loader. I think if you enable GPT in
> the 
> kernel you should be able to boot stright from the big disk.

Wow, that's unexpected but encouraging news.  What distro?  Did it
allow you to go GPT right from the off, or did you have to migrate from
an MSDOS ptbl to a GPT one after installation?

Thanks for the tip.
Neil



	
	
		
___________________________________________________________ 
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
