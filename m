Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUCaVE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCaVEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:04:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262496AbUCaVET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:04:19 -0500
Message-ID: <406B3244.4060708@pobox.com>
Date: Wed, 31 Mar 2004 16:04:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jarno Paananen <jpaana@s2.org>
CC: Petr Sebor <petr@scssoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>	<406A8035.2080108@pobox.com> <406AB08C.1040907@scssoft.com>	<406AF66B.1030205@pobox.com> <m3n05xgcf0.fsf@kalahari.s2.org>
In-Reply-To: <m3n05xgcf0.fsf@kalahari.s2.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jarno Paananen wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>Petr Sebor wrote:
>>
>>>2.6.5-rc3 + this patch:
>>>sata_via (0000:00:0f.0): PATA sharing not supported (0x2)
>>>via_sata: probe of (0000:00:0f.0) failed with error -5
>>
>>
>>Thanks for testing.  OK, one bug fix and here's a new patch...
>>
>>Thanks for all your help in narrowing this down,
> 
> 
> Thanks, that one works for me again:


cool, that's the patch I'm going with.

	Jeff



