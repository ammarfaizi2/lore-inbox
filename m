Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVKBXfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVKBXfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVKBXfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:35:07 -0500
Received: from www.eclis.ch ([144.85.15.72]:26054 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030214AbVKBXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:35:06 -0500
Message-ID: <43694DD1.3020908@eclis.ch>
Date: Thu, 03 Nov 2005 00:37:53 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch> <1130973717.27168.504.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130973717.27168.504.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> On Thu, 2005-11-03 at 00:05 +0100, Jean-Christian de Rivaz wrote:
> 
>>Since I have installed the new kernel 2.6.14, ntpd is unable to
>>synchronize the time:
> 
> 
> I'm working to see if I can reproduce this. Is this with 2.6.14 vanilla,
> or from Linus' git tree post 2.6.14?

This is a vanilla 2.6.14 kernel from Linus git tree.
The architecture is i386:
Linux talla 2.6.14 #1 PREEMPT Tue Nov 1 17:27:04 CET 2005 i686 GNU/Linux

Thanks,
-- 
Jean-Christian de Rivaz
