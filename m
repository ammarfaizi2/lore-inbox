Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbULBLV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbULBLV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbULBLV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:21:29 -0500
Received: from esacom57-ext.estec.esa.int ([131.176.107.4]:25559 "EHLO
	esacom57-int.estec.esa.int") by vger.kernel.org with ESMTP
	id S261586AbULBLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:21:23 -0500
Message-ID: <41AEFA7F.6020106@lunar-linux.org>
Date: Thu, 02 Dec 2004 12:20:31 +0100
From: Auke Kok <sofar@lunar-linux.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040617)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       vortex@scyld.com
Subject: Re: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
References: <41AE2661.2040408@lunar-linux.org> <20041201131127.208e15b6.akpm@osdl.org> <20041201172318.GK2250@dmt.cyclades>
In-Reply-To: <20041201172318.GK2250@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Wed, Dec 01, 2004 at 01:11:27PM -0800, Andrew Morton wrote:
>  
>
>>Auke Kok <sofar@lunar-linux.org> wrote:
>>    
>>
>>>This message is a confirmation on the thread by:
>>>
>>>From: Andreas Haumer
>>>Date: Tue Sep 21 2004 - 04:16:52 EST
>>>Subject: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
>>>
>>>I have 24 boxes with the same hardware and all require the patch 
>>>attached to Andreas' e-mail to function. After abusing one of them for 2 
>>>days continuously the nic hasn't shown a single flaw so far ;^)
>>>
>>>I thus would like to conclude that this patch is a valid and worthfull 
>>>addition to the 2.4.28+ kernels, as it applies cleanly to 2.4.28-final.
>>>
>>>Auke kok
>>>
>>>
>>>PS URL to the patch: 
>>>http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1215/013-3com_ati_radeon.patch
>>>      
>>>
>>That patch should of course be merged.  Please email a copy to Marcelo.
>>    
>>
>
>This has been merged together with 3c59x's v2.6 sync in 2.4.29-pre1.
>Can you give that a shot Auke?
>

2.4.29-pre1 Works perfectly. Thanks and good luck =^)

Auke Kok

--
sofar@lunar-linux.org
Lunar Linux Project leader
http://lunar-linux.org/ - It's out of this world !
