Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVHXRbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVHXRbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHXRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:31:07 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:2472 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751249AbVHXRbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:31:06 -0400
In-Reply-To: <20050824171433.GD4645@parcelfarce.linux.theplanet.co.uk>
References: <20050824171433.GD4645@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C8230D03-D0D9-4096-A995-0C1E124F665D@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       <parisc-linux@parisc-linux.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [parisc-linux] [PATCH 07/15] parisc: remove use of asm/segment.h
Date: Wed, 24 Aug 2005 12:31:11 -0500
To: "Matthew Wilcox" <matthew@wil.cx>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 24, 2005, at 12:14 PM, Matthew Wilcox wrote:

> On Wed, Aug 24, 2005 at 11:55:30AM -0500, Kumar Gala wrote:
>
>> Removed asm-parisc/segment.h as its not used by anything.
>>
>
> Did you already remove all the uses outside the parisc-specific  
> bits of
> the tree, eg ISDN, media/video/, sound/oss/, etc?
>
> If so, ACK, otherwise, NAK.

I did remove them.  I should have included a reference to the patch  
that did this:

http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/0099.html

- kumar

