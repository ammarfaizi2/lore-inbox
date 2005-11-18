Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbVKRVtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbVKRVtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKRVtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:49:06 -0500
Received: from mailhost.u-strasbg.fr ([130.79.200.155]:24312 "EHLO
	mailhost.u-strasbg.fr") by vger.kernel.org with ESMTP
	id S1161260AbVKRVtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:49:04 -0500
Message-ID: <437E4B78.80908@crc.u-strasbg.fr>
Date: Fri, 18 Nov 2005 22:45:28 +0100
From: Philippe Pegon <Philippe.Pegon@crc.u-strasbg.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051016)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikem <mikem@beardog.cca.cpqcorp.net>
CC: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, hpa@zytor.com, sitniko@infonet.ee
Subject: Re: [PATCH 1/3] cciss: bug fix for hpacucli
References: <20051118163357.GA10928@beardog.cca.cpqcorp.net>
In-Reply-To: <20051118163357.GA10928@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (mailhost.u-strasbg.fr [IPv6:2001:660:2402::155]); Fri, 18 Nov 2005 22:47:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem wrote:
> Patch 1 of 3
> 
> This patch fixes a bug that breaks hpacucli, a command line interface
> for the HP Array Config Utility. Without this fix the utility will
> not detect any controllers in the system. I thought I had already fixed
> this, but I guess not.
> 
> Thanks to all who reported the issue. Please consider this this inclusion.

reply too fast ;)
thanks you a lot for that one

--
Philippe Pegon
