Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWCPNoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWCPNoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWCPNoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:44:25 -0500
Received: from ns.protei.ru ([195.239.28.26]:1031 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S1750921AbWCPNoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:44:25 -0500
Message-ID: <44196B9A.2020705@protei.ru>
Date: Thu, 16 Mar 2006 16:43:54 +0300
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: flushing and invalidating specified cache range in ARM xScale
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys!

Is there anyway to flush/invalidate specified CPU data cache range in 
recent kernels?
Or i should use ARM DMA interface for allocating memory and forget about 
direct work
with dcache?

thanks,

Nickolay.
