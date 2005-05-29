Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVE2QgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVE2QgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVE2QgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:36:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27623 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261352AbVE2QgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:36:07 -0400
Message-ID: <4299EF74.9060506@pobox.com>
Date: Sun, 29 May 2005 12:36:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de> <20050527145821.GX1435@suse.de> <20050529131611.GB13418@merlin.emma.line.org>
In-Reply-To: <20050529131611.GB13418@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Fri, 27 May 2005, Jens Axboe wrote:
> 
> 
>>>suck and should not be cared about, and if I were to go into SATA, I
>>>should just get a new controller and forget about my onboard VIA crap.
>>>(I read newer VIA are supposed to support AHCI which is good.)
>>
>>SATA is still pretty fast without NCQ, it just makes some operations a
> 
> 
> Do I take this as SATA is faster than legacy ATA? In what respect?
> UDMA/33 and SATA I shouldn't be much different if I use the same drive,
> or is there something?

It is "likely" to be faster.  Faster bus, newer technology.

	Jeff


