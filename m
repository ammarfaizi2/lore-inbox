Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVJURDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVJURDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVJURDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:03:53 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:38414
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S965033AbVJURDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:03:38 -0400
Message-ID: <43591F69.60203@avtrex.com>
Date: Fri, 21 Oct 2005 10:03:37 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: ATI Xilleon port 10/11 Xilleon IDE controller support
References: <17239.48184.340986.463557@dl2.hq2.avtrex.com> <58cb370e0510210858k7fccc00fqd6fccffed441aae3@mail.gmail.com>
In-Reply-To: <58cb370e0510210858k7fccc00fqd6fccffed441aae3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 17:03:37.0946 (UTC) FILETIME=[611E13A0:01C5D661]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Patch basically looks fine but needs some extra work.
> Detailed comments below...
> 
> On 10/20/05, David Daney <ddaney@avtrex.com> wrote:
> 
>>This is the tenth part of my Xilleon port.
>>
>>I am sending the full set of patches to linux-mips@linux-mips.org
>>which is archived at: http://www.linux-mips.org/archives/
>>
>>Only the patches that touch generic parts of the kernel are coming
>>here.
>>
>>This patch adds the Xilleon's IDE driver.
>>
>>Patch against 2.6.14-rc2 from linux-mips.org
>>
>>Signed-off-by: David Daney <ddaney@avtrex.com>
>>

Thanks for reviewing this.  I am working on addressing the issues you 
raised.

David Daney.
