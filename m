Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUFAAE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUFAAE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 20:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbUFAAE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 20:04:26 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:63942 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S264788AbUFAAEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 20:04:25 -0400
Mime-Version: 1.0
Message-Id: <a06100505bce17827c3e8@[129.98.90.227]>
Date: Mon, 31 May 2004 20:03:25 -0400
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
>	Jeff

So do 2.6.7-rc1 and rc2.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
