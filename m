Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUJOFFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUJOFFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 01:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUJOFFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 01:05:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266250AbUJOFFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 01:05:04 -0400
Message-ID: <416F5A72.9080602@pobox.com>
Date: Fri, 15 Oct 2004 01:04:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export ata_scsi_simulate() for use by non-libata drivers
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca> <416DBC96.2090602@pobox.com> <416EA996.4040402@rtr.ca> <416EAECC.7070000@rtr.ca> <416EB1B6.5070603@pobox.com> <416EC90A.30607@rtr.ca>
In-Reply-To: <416EC90A.30607@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  >Put a prototype in linux/libata.h
> 
> Done.  Updated patch attached.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>


applied, but, you forgot rule #6:
http://linux.yyz.us/patch-format.html

Specifically, include the full description in each patch resend.  Patch 
merging is largely automated by scripts these days, and failing to 
provide an adequate description means manual intervention is required.

The full body of your email is pasted into the BitKeeper changeset 
description.

	Jeff


