Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVGaQjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVGaQjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVGaQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:39:42 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:50407 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261817AbVGaQjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:39:41 -0400
In-Reply-To: <20050727125746.54329281.akpm@osdl.org>
References: <20050727125746.54329281.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <53E238A9-96C5-444F-9620-F190560D7AF9@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>,
       Michael Richardson <mcr@sandelman.ottawa.on.ca>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Date: Sun, 31 Jul 2005 11:39:33 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Can you drop the ep405 removal patch.  We've got someone to take  
ownership.

- kumar

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
>

