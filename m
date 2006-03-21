Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWCUTmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWCUTmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWCUTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:42:09 -0500
Received: from rtr.ca ([64.26.128.89]:46300 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965076AbWCUTmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:42:08 -0500
Message-ID: <4420570B.5060304@rtr.ca>
Date: Tue, 21 Mar 2006 14:42:03 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Denis Leroy <denis@poolshark.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, lkml@rtr.ca
Subject: Re: Some sata_mv error messages
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca> <44205513.8030109@poolshark.org>
In-Reply-To: <44205513.8030109@poolshark.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Leroy wrote:
>
> This is great news. Is there any relationship between the development of
> this driver and the one maintained by Marvell that's available from
> their web site ? Their latest version (3.6.1) is released under the GPL,
>

No relationship, other than that I plan to look through their driver
for more clues to how they handle certain errata and stuff.

My employer for this project has fairly detailed information
from Marvell as well.

Cheers
