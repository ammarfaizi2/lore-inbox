Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVHUVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVHUVoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVHUVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:44:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6606 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751187AbVHUVoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:38 -0400
Message-ID: <4308AD9D.5090003@trash.net>
Date: Sun, 21 Aug 2005 18:36:45 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050821161805.74083.qmail@web33309.mail.mud.yahoo.com>
In-Reply-To: <20050821161805.74083.qmail@web33309.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:
> --- Patrick McHardy <kaber@trash.net> wrote:
>
>>Do you have netfilter enabled? Briging
>>netfilter was
>>added in 2.6, enabling it will influence
>>performance
>>negatively. Otherwise, is this performance drop
>>visible in other setups besides bridging as
>>well? 
> 
> Yes, bridging is clean. I also routed with the
> same performance drop.

In that case please send more information, like both 2.4
and 2.6 configs, dmesg output from booting, lspci output,
other hardware details, ..

