Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275510AbTHJJOF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275511AbTHJJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:14:04 -0400
Received: from sojef.skynet.be ([195.238.2.127]:40335 "EHLO sojef.skynet.be")
	by vger.kernel.org with ESMTP id S275510AbTHJJOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:14:01 -0400
Message-Id: <200308100913.h7A9DMWF001775@pc.skynet.be>
From: Hans Lambrechts <hans.lambrechts@skynet.be>
Subject: Re: APM working on SMP machines?
To: cijoml@volny.cz, linux-kernel@vger.kernel.org
Date: Sun, 10 Aug 2003 11:13:22 +0200
References: <ixTI.4cK.19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in your /etc/lilo.conf

append="apm=smp apm=power-off"

Greetings,
Hans Lambrechts



Michal Semler wrote:

> Hello,
> 
> I would like to know when will work APM on SMP machines?
> I use Dell  workstation 400 with 2 P2 CPUs.
> When I remove one CPU APM works, when I have 2 in case APM
> doesn't work
> 
> I can't use ACPI, because this machine doesn't support it.
> 
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> apm: disabled - APM is not SMP safe.
> 
> Thanks for fixing and reply - it's very uncomfortable
> switch off computer manually :(
> 
> Michal
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

