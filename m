Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCJDge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCJDge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVCJDgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:36:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35996 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262298AbVCJDea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:34:30 -0500
Message-ID: <422FC042.40303@ca.ibm.com>
Date: Wed, 09 Mar 2005 21:34:26 -0600
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>
In-Reply-To: <422FBACF.90108@ca.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Omkhar Arasaratnam wrote:

> Benjamin Herrenschmidt wrote:
>
>> Are you sure it's plain 2.6.11 and not some bk clone of after 2.6.11 was
>> released ?
>>
>>  
>>
> Ben - I am in the process of downloading a clean tarball from 
> kernel.org to be 100% certain.

I confirmed that this occurs with the 2.6.11 code straight from 
kernel.org Here is an error from the bringup:

sym0: No NVRAM, ID 7, Fast-80 LVD, parity checking
CACHE TEST FAILED: DMA error (dstat=0xa0) .sym0: CACHE INCORRECTLY 
CONFIGURED
sym0: giving up ...

ideas?

Omkhar

