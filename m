Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTLOPkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTLOPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:40:55 -0500
Received: from fmr99.intel.com ([192.55.52.32]:46816 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263662AbTLOPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:40:54 -0500
Message-ID: <3FDDD5FE.5010001@intel.com>
Date: Mon, 15 Dec 2003 17:40:46 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
References: <12KJ6-4F2-13@gated-at.bofh.it> <12XQc-7Vs-29@gated-at.bofh.it>	<12Z5u-1tG-11@gated-at.bofh.it> <m3iskip1py.fsf@averell.firstfloor.org>
In-Reply-To: <m3iskip1py.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, I am also thinking in this direction. I already started 
conversation to implement some standard method.

Vladimir.

Andi Kleen wrote:

>Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>  
>
>>I thought this way also. But I found that it is not. You may know
>>several chipsets,
>>and do per-chipset stuff, but there is no generic procedure. At least
>>authors of PCI-E
>>don't know (it is nice to have access to the authors ;-) ).
>>    
>>
>
>This sounds like a serious design flaw in PCI-Express. Can you 
>ask them to address this before it is too late? 
>
>-Andi
>  
>

