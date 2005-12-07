Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbVLGXMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVLGXMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVLGXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:12:41 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:59992 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030425AbVLGXMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:12:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0kLAuMViQzhFgLsrW29pv9ugSE2fKIeN1PITVsFtKA8UsVHFHS7ijuHqLjXZRqgJUv0RxpIb1WqIPpRy//iPSO74Vg9Xbzn5qCuDtRYURNJ6Y0BnuDaEOV7nsHlQRoKpT4QPHnHhnKqt04srZ7ONx0gYtrPbl6bS6Bx5v4P+tcc=  ;
Message-ID: <43976C63.7020107@yahoo.com.au>
Date: Thu, 08 Dec 2005 10:12:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
       johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu> <4396B81E.4030605@yahoo.com.au> <20051207104900.GA26877@elte.hu> <4396C2EB.1000203@yahoo.com.au> <Pine.LNX.4.61.0512071335180.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512071335180.1609@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Roman Zippel wrote:
> 
> Nick, thanks for speaking up about this.
> My mistake was to make a big deal out of it, because I knew it would 
> confuse more people. After I got the heat for this, it seems nobody else 
> want to get flamed for it.
> 

I didn't mean to trivialise the issue. I think good naming is
important, however I added the disclaimer because of course I
didn't write any code, so my opinion didn't carry much weight
in that particular situation compared to you guys.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
