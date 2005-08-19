Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVHSRpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVHSRpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVHSRpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:45:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932665AbVHSRpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:45:16 -0400
Message-ID: <43061A9E.4050408@pobox.com>
Date: Fri, 19 Aug 2005 13:45:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git] libata-dev queue updated
References: <20050819035437.GA18324@havoc.gtf.org> <4305C5AA.20200@emc.com>
In-Reply-To: <4305C5AA.20200@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>> In such cases, patches are divided into branches by category: ncq (NCQ
>> queueing support), chs-support (C/H/S support), adma (new ADMA driver),
>> sil24 (new Silicon Image 312x driver), passthru (ATA passthrough/SMART
>> support), etc.
>>  
>>
> Jeff,
> The below doesn't seem to include NCQ. Is this an oversight?

No.  NCQ is a separate branch, for now.

	Jeff



