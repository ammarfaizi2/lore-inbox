Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUEWCs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUEWCs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 22:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUEWCs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 22:48:27 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:19181 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S262114AbUEWCsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 22:48:17 -0400
Mime-Version: 1.0
Message-Id: <a06100553bcd5c0a27f8b@[129.98.90.227]>
In-Reply-To: <40AE4DDC.7050508@pobox.com>
References: <a06100547bcd3f33b5b73@[129.98.90.227]>
 <40AE4DDC.7050508@pobox.com>
Date: Sat, 22 May 2004 22:48:37 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: tg3 module in kernel 2.6.5 panics
Cc: Jeff Garzik <jgarzik@pobox.com>, aj@andaco.de, davem@nuts.davemloft.net,
       mchan@broadcom.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maurice Volaski wrote:
>>The tg3 module in (gentoo) kernel 2.6.5 panics on boot on a 
>>dual-opteron 248 box with 4G RAM. I copied the following screen 
>>output...
>
>
>This looks like kobject stuff unrelated to tg3.
>
>Does 2.6.6 fail similarly?
>

Gentoo has only 2.6.6-rc3 available, and it crashes too, but at an 
earlier point, so you are right, it's not tg3. Will test again as 
Gentoo provides final 2.6.6.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
