Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWB1P5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWB1P5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWB1P5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:57:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:13471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751493AbWB1P5n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:57:43 -0500
Message-ID: <440472F6.6090905@suse.de>
Date: Tue, 28 Feb 2006 16:57:42 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
References: <44045FB1.5040408@suse.de> <440468DB.5060605@pobox.com> <20060228151928.GC24981@suse.de> <44046AC2.1060002@pobox.com> <20060228152847.GE24981@suse.de> <44046DC3.4060508@pobox.com>
In-Reply-To: <44046DC3.4060508@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Jens Axboe wrote:
>> I'm sure Hannes will regenerate against upstream as well if necessary,
>> however that depends on when this should be applied.
> 
> It's far too late and too intrusive for 2.6.16-rc.
> 
> It's #upstream or <null>.
> 
Calm down. Of course I will regenerate is against #upstream.
In fact, I've done so initially but wasn't sure what the status of
libata-dev is. So I've diffed it against linux-git instead.

Updated patch to follow.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

