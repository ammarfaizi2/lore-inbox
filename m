Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWEKXxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWEKXxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWEKXxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:53:41 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:17845 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750841AbWEKXxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:53:40 -0400
Message-ID: <4463CE7A.3030601@myri.com>
Date: Fri, 12 May 2006 01:53:30 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
References: <446259A0.8050504@myri.com>	<Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>	<20060510150112.46a732d4@localhost.localdomain> <ada8xp97cx8.fsf@cisco.com>
In-Reply-To: <ada8xp97cx8.fsf@cisco.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Stephen> Splitting it in half, might help email restrictions, but
>     Stephen> it kills future users of 'git bisect' who expect to have
>     Stephen> every kernel buildable.
>
> Not really, since the makefile/kconfig stuff comes in a later patch.
>
> But yes, it is cleaner to have drivers go in in sane pieces.
>   

Yes sure. But the submission was not supposed to get merged as is
anyway, so I thought breaking the driver was not a big deal for this time.

By the way, what's the exact message size limit ?

Brice

