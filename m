Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVH3BuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVH3BuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVH3BuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:50:05 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:59541 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750854AbVH3BuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:50:04 -0400
In-Reply-To: <20050727125746.54329281.akpm@osdl.org>
References: <20050727125746.54329281.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0048AEBE-072F-4250-9D32-EC019D0BDBB9@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, <linuxppc-embedded@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Date: Mon, 29 Aug 2005 20:46:22 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.734)
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

No one has screamed about anything but ep405 so all the others should  
go to Linus now.

- kumar

