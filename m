Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWARAkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWARAkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWARAkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:40:07 -0500
Received: from mail.dvmed.net ([216.237.124.58]:63920 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964994AbWARAkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:40:05 -0500
Message-ID: <43CD8E62.7060301@pobox.com>
Date: Tue, 17 Jan 2006 19:40:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Backlund <tmb@mandriva.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com> <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com> <43B16B06.3000401@mandriva.org>
In-Reply-To: <43B16B06.3000401@mandriva.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Thomas Backlund wrote: > Jeff Garzik wrote: > >> Thomas
	Backlund wrote: >> >>> Richard Bollinger wrote: >>> >>>>> ata1: BUG: SG
	size underflow >>>>> ata1: status=0x50 { DriveReady SeekComplete } >>>
	>>> >>> >>> and onde by one the raid devices got deactivated until the
	full >>> freeze... >> >> >> >> I think I know what's going on with the
	'SG size underflow' thingy, >> give me a few days to come up with a
	fix. >> >> Jeff >> >> >> > Any news on this? > or is it already fixed ?
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Backlund wrote:
> Jeff Garzik wrote:
> 
>> Thomas Backlund wrote:
>>
>>> Richard Bollinger wrote:
>>>
>>>>> ata1: BUG: SG size underflow
>>>>> ata1: status=0x50 { DriveReady SeekComplete }
>>>
>>>
>>>
>>> and onde by one the raid devices got deactivated until the full 
>>> freeze...
>>
>>
>>
>> I think I know what's going on with the 'SG size underflow' thingy, 
>> give me a few days to come up with a fix.
>>
>>     Jeff
>>
>>
>>
> Any news on this?
> or is it already fixed ?

Back-burner for the moment :(

	Jeff



