Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUBYS5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbUBYS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:56:41 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:36104 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261535AbUBYSzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:55:32 -0500
Message-ID: <403CF1FF.2080907@techsource.com>
Date: Wed, 25 Feb 2004 14:05:35 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com> <403CCBE0.7050100@techsource.com> <c1ihqh$e0r$1@terminus.zytor.com> <403CD900.6080003@techsource.com> <403CD852.1060200@zytor.com>
In-Reply-To: <403CD852.1060200@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Timothy Miller wrote:
> 
>>
>> I think we were talking about absolute branches when referring to 
>> "near branches".  For absolute branches, having a 32-bit address 
>> restricts you to the lower 4G of the address space.
>>
> 
> You're talking about *indirect* near branches?  Those are the only 
> absolute near branches which exist...


I don't know.  I seem to vaguely recall seeing some disassembled x86 
code which was a branch which had an absolute address.  Maybe I remember 
incorrectly.

