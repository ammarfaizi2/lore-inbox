Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWHHSYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWHHSYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWHHSYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:24:32 -0400
Received: from stinky.trash.net ([213.144.137.162]:936 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S964976AbWHHSYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:24:31 -0400
Message-ID: <44D8D6DB.6040007@trash.net>
Date: Tue, 08 Aug 2006 20:24:27 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc4
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org> <Pine.LNX.4.61.0608081943470.18225@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608081943470.18225@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>It's been a week since -rc3, so now we have a -rc4.
> 
> 
> 2.6.18 comes with ipt_statistic, but there is no way from userspace 
> (iptables) to use it (libipt_statistic.so simply does not come with the 
> latest iptables from svn). Does someone know what's going on?

I still have to add the userspace part to SVN.
