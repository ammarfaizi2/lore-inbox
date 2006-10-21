Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766611AbWJUR5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766611AbWJUR5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766628AbWJUR5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:57:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:28216 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1766611AbWJUR5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:57:45 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,338,1157353200"; 
   d="scan'208"; a="148609454:sNHT48437039"
Message-ID: <453A5F51.9080803@intel.com>
Date: Sat, 21 Oct 2006 10:56:33 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>,
       "Allan, Bruce W" <bruce.w.allan@intel.com>
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com> <20061017222727.GB24891@tau.solarneutrino.net> <45390E09.7050508@intel.com> <20061020180610.GA17675@mail.muni.cz> <20061021173402.GA30750@tau.solarneutrino.net>
In-Reply-To: <20061021173402.GA30750@tau.solarneutrino.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
> On Fri, Oct 20, 2006 at 08:06:10PM +0200, Lukas Hejtmanek wrote:
>> On Fri, Oct 20, 2006 at 10:57:29AM -0700, Auke Kok wrote:
>>> To all that are seeing this problem:
>>>
>>> can you send me (off-list is OK) the motherboard number+name, the BIOS 
>>> versions (+ where you downloaded them from) that you have tried and for 
>>> each version, whether it worked without this workaround or not?
 >>
>> Three days ago, Intel released a new BIOS version that claims to fix
>> this issue.
>>
>> I've tested it with 2.6.18 kernel which was unable to restart, it
>> works now so it seems that fix was successful.
> 
> I just tried the 1458 BIOS without the workaround and it's working fine.

okay, looks like the latest BIOS fixes it (hang on reboot/restart) for everyone. Thanks 
for reporting back in, I'll make sure my colleagues write this down for everyone.

Cheers,

Auke
