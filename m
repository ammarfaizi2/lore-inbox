Return-Path: <linux-kernel-owner+w=401wt.eu-S933062AbWLSXOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062AbWLSXOr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933064AbWLSXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:14:46 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:37380 "EHLO
	nommos.sslcatacombnetworking.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933062AbWLSXOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:14:46 -0500
X-Greylist: delayed 25272 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 18:14:46 EST
In-Reply-To: <20061219041254.GB6993@stusta.de>
References: <20061124234935.GJ28363@stusta.de> <20061219041254.GB6993@stusta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3B7827F6-D6CA-481F-B6DE-0F0B2AB4F632@kernel.crashing.org>
Cc: paulus@samba.org, Kumar Gala <galak@freescale.com>,
       linuxppc-dev@ozlabs.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [2.6 patch] powerpc: remove the broken Gemini support
Date: Tue, 19 Dec 2006 10:13:29 -0600
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18, 2006, at 10:12 PM, Adrian Bunk wrote:

> On Sat, Nov 25, 2006 at 12:49:35AM +0100, Adrian Bunk wrote:
>> I just saw the commit message below.
>>
>> There seems to have been some although unmerged work on APUS  
>> support by
>> Roman, but I didn't find any recent work on bringing the GEMINI  
>> support
>> back into life.
>>
>> Is this a wrong impression, or would a patch to remove it be OK?
>> ...
>
> Zero feedback, patch to remove it below.
>
> cu
> Adrian

I'm good with removing GEMINI since no one seems to have raised any  
fuss about this and I brought the issue up over a year ago now.   
However, I leave the final decision up to Paul.

Also, where do we stand with APUS?

- k
