Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSKOE04>; Thu, 14 Nov 2002 23:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265759AbSKOE04>; Thu, 14 Nov 2002 23:26:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265757AbSKOE0z>; Thu, 14 Nov 2002 23:26:55 -0500
Message-ID: <3DD47908.5010405@zytor.com>
Date: Thu, 14 Nov 2002 20:33:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] early printk for x86
References: <3DD3FCB3.40506@us.ibm.com.suse.lists.linux.kernel> <3DD40719.5030108@pobox.com.suse.lists.linux.kernel> <3DD428C3.4030700@us.ibm.com.suse.lists.linux.kernel> <20021115044300.C20764@wotan.suse.de.suse.lists.linux.kernel> <ar1sdm$gfe$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73u1ijv4gw.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> But then assuming they have PC style VGA/serial is a pretty big
> assumption too.
> 

That's a configure option more than anything else, IMO.

> It is probably better hidden in arch/

It's not arch though; rather it's a platform option.

	-hpa


