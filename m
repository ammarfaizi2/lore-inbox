Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVJMUOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVJMUOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJMUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:14:46 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:62140 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932491AbVJMUOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:14:46 -0400
Message-ID: <434EC01E.4000008@g-house.de>
Date: Thu, 13 Oct 2005 22:14:22 +0200
From: Christian <evil@g-house.de>
User-Agent: Mail/News 1.6a1 (Windows/20051004)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, GregKH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Dallas's 1-wire bus compile error (again)
References: <434EA63F.10306@g-house.de> <20051013183353.GA32530@2ka.mipt.ru> <434EB375.4060104@g-house.de> <20051013194705.GA27809@2ka.mipt.ru>
In-Reply-To: <20051013194705.GA27809@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0539-6, 02.10.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> 
> It looks like you use old version - I've just compiled 
> today's git tree with your config, and it does have an error, 
> but in different place.

i've tested against 2.6.13.4 and a current -git tree when the error
showed up.

but your patch fixes it.

thank you for your time,
Christian.
-- 
BOFH excuse #19:

floating point processor overflow

