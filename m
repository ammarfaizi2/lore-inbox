Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269746AbUICR6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269746AbUICR6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269723AbUICRxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:53:15 -0400
Received: from [195.23.16.24] ([195.23.16.24]:23970 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269718AbUICRvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:51:12 -0400
Message-ID: <4138AF0C.4010703@grupopie.com>
Date: Fri, 03 Sep 2004 18:51:08 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903172354.GR3106@holomorphy.com>
In-Reply-To: <20040903172354.GR3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.44; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
>>- Added the m32r architecture.  Haven't looked at it yet.
>>- Status update on various large patches in -mm:
> 
> [...]
> 
> kallsyms still looks funny even with the latest fixes. dmesg follows.
> Cheers.

Could you send me the .tmp_kallsyms2.S and System.map files from
this kernel build, please, please, please?

I really want to address this problem, but without hardware and
without more information I'm a little in the dark (although
looking at the resulting names already gives some clues).

Also, doing a "cat /proc/kallsyms" shows the same kind of behavior,
doesn't it? (just to be sure)

TIA,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
