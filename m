Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVKLF2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKLF2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKLF2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:28:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:38286 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932101AbVKLF2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:28:07 -0500
Message-ID: <43757D5C.8030308@pobox.com>
Date: Sat, 12 Nov 2005 00:27:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org, jonathan@buzzard.org.uk,
       tlinux-users@linux.toshiba-dme.co.jp, Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC: 2.6 patch] remove ISA legacy functions
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111202005.GQ5376@stusta.de> <20051111203601.GR5376@stusta.de> <20051112045216.GY5376@stusta.de> <437578CD.1080501@pobox.com> <20051112051102.GF1658@parisc-linux.org>
In-Reply-To: <20051112051102.GF1658@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Nov 12, 2005 at 12:08:29AM -0500, Jeff Garzik wrote:
> 
>>it's not valid to mark working drivers broken, IMO.
>>
>>Mark them x86-only, perhaps.
> 
> 
> hp100 works fine on parisc.

Certainly.  The point was, don't mark them broken, limit them to the 
arches where they work.

	Jeff



