Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWCUThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWCUThU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWCUThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:37:19 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:4013 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965059AbWCUThS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:37:18 -0500
Message-ID: <442055E9.4010708@pobox.com>
Date: Tue, 21 Mar 2006 14:37:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Leroy <denis@poolshark.org>
CC: Mark Lord <liml@rtr.ca>, sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca
Subject: Re: Some sata_mv error messages
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca> <44205513.8030109@poolshark.org>
In-Reply-To: <44205513.8030109@poolshark.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Leroy wrote:
> This is great news. Is there any relationship between the development of
> this driver and the one maintained by Marvell that's available from
> their web site ? Their latest version (3.6.1) is released under the GPL,
> and is a very solid driver based our experience with it over the past
> few years, though it's targeted at older versions of the linux kernel
> and needs some porting to 2.6.16 (and contains redundant stuff like its
> own scsi-ata layer).

There is a we-use-that-driver-as-documentation-sometimes relationship.

It's quite un-Linux for a Linux driver, and others have reported that 
sata_mv in its current state is more stable for them than the Marvell 
behemoth GPL driver.

	Jeff


