Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbTGTSdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbTGTSdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:33:02 -0400
Received: from dsl081-085-006.lax1.dsl.speakeasy.net ([64.81.85.6]:48091 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S267685AbTGTSc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:32:56 -0400
Message-ID: <3F1AE3DA.5060407@tmsusa.com>
Date: Sun, 20 Jul 2003 11:47:54 -0700
From: Joe <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
References: <20030720125547.11466aa4.florian.huber@mnet-online.de> <1058702109.691.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1058702109.691.0.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>On Sun, 2003-07-20 at 12:55, Florian Huber wrote:
>  
>
>>Hello ML,
>>I can't boot my 2.6.0-test1-mm2 kernel (+GCC 3.3). The kernel panics
>>at bootime:
>>
>>VFS: Cannot open root device "hda3" or unknow-block(0,0)
>>Please append a correct "root=" boot option
>>Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
>>
>>I do have compiled support for the file system on my root partition
>>(xfs). The same configuration worked well with 2.6.0-test1-mm1.
>>
>>Perhaps somebody knows how to solve this.
>>    
>>
>
>I've also seen this when trying to boot -mm2. Every configuration option
>was left as it was in -mm1. Andrew, any ideas?
>  
>
FWIW, I have the same problem with -mm2, -mm1 was fine, same config.

Joe

