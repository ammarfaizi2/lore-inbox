Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUDDR3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUDDR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 13:29:08 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:53258 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S262503AbUDDR3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 13:29:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Thomas Beneke <thomas.beneke@web.de>
Newsgroups: linux.kernel
Subject: Re: 2.6.4 & 2.6.5 breaks e100 support on my laptop
Date: Sun, 04 Apr 2004 19:28:39 +0200
Organization: Tiscali Germany
Message-ID: <c4pgku$15ua$1@ulysses.news.tiscali.de>
References: <1HhT9-3MH-7@gated-at.bofh.it> <1HiYZ-4FS-41@gated-at.bofh.it>
NNTP-Posting-Host: p83.129.109.197.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1081099742 38858 83.129.109.197 (4 Apr 2004 17:29:02 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sun, 4 Apr 2004 17:29:02 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
In-Reply-To: <1HiYZ-4FS-41@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernt Hansen wrote:
> Nevermind.  I must have had some weird configuration SNAFU.
> 
> It's working now :)  
> 
> Bernt.
> 
> On Sun, Apr 04, 2004 at 11:30:50AM -0400, Bernt Hansen wrote:
> 
>>Hi,
>>
>>I have a Toshiba Tecra S1 laptop with a built-in ethernet card which
>>uses the e100 driver.  The ethernet works fine with linux kernel 2.6.3.
>>As of 2.6.4 (and 2.6.5) I get the following message at startup:
>>
>>e100: Intel(R) PRO/100 Network Driver, 3.0.17
>>e100: Copyright(c) 1999-2004 Intel Corporation
>>PCI: Enabling device 0000:02:08.0 (0000 -> 0003)
>>PCI: Setting latency timer of device 0000:02:08.0 to 64
>>e100: eth%d: e100_eeprom_load: EEPROM corrupted
>>e100: probe of 0000:02:08.0 failed with error -11
>>
>>and the ethernet no longer works.  (The 2nd last message eth%d is
>>probably missing the ethernet number as a parameter to this printk)
>>
>>Please cc: me in replies since I am not subscribed to the list.
>>
>>Let me know if there is anything I can do to help fix this problem.
>>
>>Thanks,
>>Bernt.
>>-- 
>>Bernt Hansen     Norang Consulting Inc.
> 
> 
I've no probs with same hardware + kernel.

Regards,
Thomas
