Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVLGKXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVLGKXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVLGKXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:23:37 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:3499 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750788AbVLGKXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZXsMLJoXAQG71yQ3DYDRNbWvE734BsSBgZ4e5L70Mcs1c9c2JjN7KlYVnoT9mHN1D5WmERkhx4jvvq8bXnNUOs7tj09I8j7rXuArG6xwUBNavtNCeFRSB2gc1ErG47pF4r5lmrde2WAWkxQnrxlgSfCaj0LyoLvZ9v90HjVJgcA=  ;
Message-ID: <4396B81E.4030605@yahoo.com.au>
Date: Wed, 07 Dec 2005 21:23:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu>
In-Reply-To: <20051207101137.GA25796@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> so i believe that:
> 
> 	- 'struct ktimer', 'struct ktimeout'
> 
> is in theory superior naming, compared to:
> 
> 	- 'struct ptimer', 'struct timer_list'
> 

Just curious -- why the "k" thing?

Send instant messages to your online friends http://au.messenger.yahoo.com 
