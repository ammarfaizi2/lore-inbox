Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVCHMJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVCHMJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCHMHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:07:43 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:52913 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S262026AbVCHMA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:00:58 -0500
Message-ID: <422D93FB.2030103@tomt.net>
Date: Tue, 08 Mar 2005 13:00:59 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-ac1
References: <1110231261.3116.90.camel@localhost.localdomain>
In-Reply-To: <1110231261.3116.90.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
<snip>
> Functionality
> o	PWC USB camera driver
> o	Working ULI526X support (added to base in .11 but broken)
> o	ATP88x support
> o	Intelligent misrouted IRQ handlers
> o	Fix PCI boxes that take minutes IDE probing
> o	Remove bogus confusing XFree86 keyboard message
> o	Support fibre AMD pcnet32
> o	Runtime configurable clock
> 	| So you can run laptops usefully. Set 100Hz to fix
> 	| the power drain, clock sliding and other problems
> 	| 1000Hz causes
> o	Fix token ring locking so token ring can be used again
> o	x86_64/32 cross build fixes
> o	NetROM locking fixes (so NetROM actually works!)
> o	SUID dumpable support
> o	Don't log pointless CD messages
> o	Minimal stallion driver functionality

Incomplete list? Seems like there is quite a bit of changes in the diff 
not mentioned "changelog" - HPT, generic ide, ide_dma rename, serio 
"spank" stuff, pci ids

-- 
Mvh,
André Tomt
