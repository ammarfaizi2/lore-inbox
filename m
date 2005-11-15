Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVKOPPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVKOPPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVKOPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:15:32 -0500
Received: from mail.dvmed.net ([216.237.124.58]:20649 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932536AbVKOPPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:15:31 -0500
Message-ID: <4379FB8C.3050904@pobox.com>
Date: Tue, 15 Nov 2005 10:15:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <20051114050404.GA18144@havoc.gtf.org> <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de> <4379F31D.4000508@pobox.com> <Pine.LNX.4.63.0511151554330.3015@dingo.iwr.uni-heidelberg.de>
In-Reply-To: <Pine.LNX.4.63.0511151554330.3015@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> I don't think that this is really what you wanted - you probably wanted 
> the place in libata where insmod stops, but the root FS is on another 
> SATA disk connected to the ICH6, so if I enable DEBUG for libata this 
> controller/disk will log quite a lot, right ?

Correct on all counts :(

	Jeff


