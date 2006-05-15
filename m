Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWEOTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWEOTdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEOTdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:33:13 -0400
Received: from rtr.ca ([64.26.128.89]:47553 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751494AbWEOTdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:33:12 -0400
Message-ID: <4468D777.6080408@rtr.ca>
Date: Mon, 15 May 2006 15:33:11 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org>
In-Reply-To: <4468C33F.7070905@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
..
>> http://bugzilla.kernel.org/show_bug.cgi?id=5586
> 
> sata_mv still considered highly experimental, as noted in Kconfig.  Bugs 
> deferred to Mark Lord.
..
I think that particular bug has gone away with my internal sata_mv.c version.
I'm updating it for release on top of Jeff/Tejun's patch set, and will likely
backport the bugfixes to 2.6.16.xx as well.  Timeline, this week or next.

Cheers 
