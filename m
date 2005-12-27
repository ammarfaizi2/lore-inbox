Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVL0QZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVL0QZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVL0QZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:25:53 -0500
Received: from mbox2.netikka.net ([213.250.81.203]:18153 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S932341AbVL0QZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:25:52 -0500
Message-ID: <43B16B06.3000401@mandriva.org>
Date: Tue, 27 Dec 2005 18:25:42 +0200
From: Thomas Backlund <tmb@mandriva.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com> <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com>
In-Reply-To: <439899B6.2000302@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Thomas Backlund wrote:
>> Richard Bollinger wrote:
>>>> ata1: BUG: SG size underflow
>>>> ata1: status=0x50 { DriveReady SeekComplete }
>>
>>
>> and onde by one the raid devices got deactivated until the full 
>> freeze...
>
>
> I think I know what's going on with the 'SG size underflow' thingy, 
> give me a few days to come up with a fix.
>
>     Jeff
>
>
>
Any news on this?
or is it already fixed ?

--
Regards

Thomas

