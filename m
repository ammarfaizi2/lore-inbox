Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVI2S0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVI2S0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVI2S0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:26:19 -0400
Received: from mailrly04.isp.novis.pt ([195.23.133.214]:20203 "EHLO
	mailrly04.isp.novis.pt") by vger.kernel.org with ESMTP
	id S932444AbVI2S0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:26:18 -0400
Message-ID: <433C31C8.1030901@vgertech.com>
Date: Thu, 29 Sep 2005 19:26:16 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34>
In-Reply-To: <Pine.LNX.4.63.0509290916450.20827@p34>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Under 2.6.13.2,
> 
> Is there any utility that I can use to put a SATA HDD to sleep?
> Secondly, I notice I cannot access any of the HDD's S.M.A.R.T. functions 
> on SATA drives?

Search for Jeff's patch 2.6.12-git4-passthru1.patch
I think this will be included RSN. This solves your two issues.

Regards,
Nuno Silva

