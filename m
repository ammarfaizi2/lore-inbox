Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVHKSdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVHKSdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVHKSdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:33:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30119 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932349AbVHKSdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:33:10 -0400
Message-ID: <42FB99D7.6030403@pobox.com>
Date: Thu, 11 Aug 2005 14:32:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, lgb@lgb.hu,
       Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>	 <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <42FB8D04.8050006@gmail.com> <42FB8F0D.6060202@pobox.com> <42FB9191.6050602@gmail.com>
In-Reply-To: <42FB9191.6050602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Jeff Garzik schrieb:
>> Please enable ATA_DEBUG and ATA_VERBOSE_DEBUG, and send me the output.
> 
> 
> I tried that Jeff, but the base problem is on the low-level..


There may be a BIOS problem, but there is no problem with the controller 
using SATA II drives.

Can you boot with another drive, and then send the output requested above?

	Jeff



