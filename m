Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUEPPB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUEPPB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUEPPB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:01:57 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:37538 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263600AbUEPPB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:01:56 -0400
Message-ID: <40A78272.4020404@uni-paderborn.de>
Date: Sun, 16 May 2004 17:02:10 +0200
From: Alexander Bruder <anib@uni-paderborn.de>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
References: <200405161427.44859.p_christ@hol.gr> <200405161528.43329.lkml@kcore.org>
In-Reply-To: <200405161528.43329.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> The fact is, it worked _perfectly_ under 2.6.5 with the standard mode. No 
> problems whatsoever. Something must have changed (but I'm too unfamiliar with 
> kernel code) that causes some sort of a delay in the processing of the input 
> queue of the touchpad. 

same problem here with 2.6.6 (recent gentoo system). I am running 
2.6.6-rc3 and 2.6.5 without the problems.


Alexander

> I've upgraded the X driver, but that changes nothing.
> 
> Jan
> 


