Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVFQINC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVFQINC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFQINB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:13:01 -0400
Received: from mail2.designassembly.de ([217.11.62.46]:56533 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S261905AbVFQIMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:12:55 -0400
Message-ID: <42B28604.4030300@designassembly.de>
Date: Fri, 17 Jun 2005 10:12:52 +0200
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050412)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>	 <42B14415.5060105@designassembly.de> <Pine.LNX.4.63.0506160523190.6459@p34> <1118933954.2644.8.camel@mindpipe>
In-Reply-To: <1118933954.2644.8.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Are you both using NFS + software RAID?  Is 4KSTACKS enabled?
> 
> IIRC people were getting stack overflows with the NFS + RAID + 4K stacks
> combination.

In my case 4k stacks are enabled. Thanks for the hint, I'll try again with 8k stacks.

Michael
