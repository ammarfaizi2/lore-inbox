Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVKBSEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVKBSEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVKBSEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:04:15 -0500
Received: from ra.sai.msu.su ([158.250.29.2]:22489 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S965137AbVKBSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:04:14 -0500
Date: Wed, 2 Nov 2005 21:03:59 +0300 (MSK)
From: Evgeny Rodichev <er@sai.msu.su>
To: bloch@verdurin.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 error with Megaraid on x86_64 with 8GB RAM
In-Reply-To: <20051102134501.GC16564@bloch.smith.man.ac.uk>
Message-ID: <Pine.GSO.4.63.0511022101260.3912@ra.sai.msu.su>
References: <20051102132034.GB16564@bloch.smith.man.ac.uk>
 <20051102134501.GC16564@bloch.smith.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, bloch@verdurin.com wrote:

> On Wed, 02 Nov 2005, bloch@verdurin.com wrote:
>
>> Three times now I've seen severe ext3 problems on two different Opteron
>> machines with 8G RAM.  Two other machines with 4G are otherwise
>> identical but haven't exhibited the same filesystem problems.
>>
>> The corruption occurs on a Megaraid RAID 1 array.


The problem looks very similar to my problem with Opteron and 8G RAM.
Please send the output from lspci -v and dmesg

_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
