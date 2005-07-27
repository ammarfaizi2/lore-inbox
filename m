Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVG0Xfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVG0Xfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0Xfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:35:46 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:15530 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261242AbVG0Xfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:35:30 -0400
In-Reply-To: <20050727125746.54329281.akpm@osdl.org>
References: <20050727125746.54329281.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA8992D4-1960-48BA-B5C2-CDC81CE21CE7@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, <linuxppc-embedded@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Date: Wed, 27 Jul 2005 18:35:23 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 27, 2005, at 2:57 PM, Andrew Morton wrote:

> Kumar Gala <galak@freescale.com> wrote:
>
>>
>> The following board ports are no longer maintained or have become
>>  obsolete:
>>
>>  adir
>>  ash
>>  beech
>>  cedar
>>  ep405
>>  k2
>>  mcpn765
>>  menf1
>>  oak
>>  pcore
>>  rainier
>>  redwood
>>  sm850
>>  spd823ts
>>
>>  We are there for removing support for them.
>>
>
> I'll merge all these into -mm for now, but will hold off sending  
> any of
> them upstream pending confirmation of which patches we really want to
> proceed with.

Sounds good.  We will get to some resolution on the ep405 which seems  
the be the only system that people are making noise on today.

- kumar

