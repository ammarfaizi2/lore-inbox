Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVBOQHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVBOQHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVBOQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:07:34 -0500
Received: from postman.ripe.net ([193.0.0.199]:36535 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S261770AbVBOQHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:07:16 -0500
Message-ID: <42121E5B.2010503@colitti.com>
Date: Tue, 15 Feb 2005 17:07:55 +0100
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: s0348365@sms.ed.ac.uk
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk> <4211E729.1090305@colitti.com> <200502151317.15633.s0348365@sms.ed.ac.uk>
In-Reply-To: <200502151317.15633.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_00
X-RIPE-Spam-Status: N 0.120259 / -5.9
X-RIPE-Signature: 4db30108bcfd119583b25cb61e4664fa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
>>.config attached.
> 
> As recommended elsewhere in this thread, I'm not using any sort of framebuffer 
> driver, but vesafb IS compiled in (but no vga= option is present). Does it 
> need to be compiled out completely?

I don't remember, maybe you can deduce it from the .config I sent?

> I have acpi_sleep=s3_bios on cmdline. I am not using swsusp2 (and I can't see 
> how this is at all related to software suspend).

It works with or without swsusp2.

> Perhaps it is the machine BIOS. Which version do you have?

I think it's vF.0F from July 2004.


Cheers,
Lorenzo
