Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTHDOPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271741AbTHDOPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:15:07 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:20722 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271738AbTHDOPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:15:04 -0400
Message-ID: <3F2E6A86.3060402@softhome.net>
Date: Mon, 04 Aug 2003 16:15:34 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <jesse@cats-chateau.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
References: <gq0f.8bj.9@gated-at.bofh.it> <gvCD.4mJ.5@gated-at.bofh.it> <gJmp.7Th.33@gated-at.bofh.it> <gNpS.2YJ.9@gated-at.bofh.it>
In-Reply-To: <gNpS.2YJ.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
>>3k of code.
>>not 650k of bzip.
> 
> And it handles ipfilter?
> and LSM security hooks?
> how about IPSec?
> and IPv6?
> 
> I don't think so.

   Answer is "No".

   I'm running expensive workstation - and I'm _NOT_ using 
LSM/IPSec/IPv6. I do not care what I _*can*_ do - I care about what I 
_*need*_ to do.
   Point is here that 3k of code is all what we need. Not 'what every 
one does need', not Linux kernel.

P.S.
   printk() is absolutely renundant since there is no display at all ;-)
   And can you imagine Linux without printk, bug_on & panic?-)))

