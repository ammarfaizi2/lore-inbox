Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUGLR25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUGLR25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUGLR25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:28:57 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:56307 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S266892AbUGLR2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:28:55 -0400
Message-ID: <40F2CAD4.6040000@am.sony.com>
Date: Mon, 12 Jul 2004 10:31:00 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adam Kropelin <akropel1@rochester.rr.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com>	<20040710115413.A31260@mail.kroptech.com>	<20040710142800.A5093@mail.kroptech.com>	<200407101319.31147.dtor_core@ameritech.net>	<099101c466ba$7d75aa30$03c8a8c0@kroptech.com>	<20040710182527.47534358.akpm@osdl.org>	<20040710234459.A26981@mail.kroptech.com> <20040710213824.501545fb.akpm@osdl.org>
In-Reply-To: <20040710213824.501545fb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adam Kropelin <akropel1@rochester.rr.com> wrote:
> 
>>Actually, there are no ifdefs at all (unless there are some
>> auto-generated ones I don't know about).
> 
> 
> OK, I should have looked and not guessed ;)
> 
> 
>> Thanks for your feedback. Here's a patch implementing your suggestions.
> 
> 
> Thanks.  Tim, could you please review-n-test this?

Yes.  I'll give it a full run-through today.

=============================
Tim Bird
Bootup Time Working Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
