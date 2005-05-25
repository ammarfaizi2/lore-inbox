Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVEYHNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVEYHNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVEYHMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:12:38 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:51822 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262303AbVEYHGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:06:18 -0400
Message-ID: <429423E1.6050603@yahoo.com.au>
Date: Wed, 25 May 2005 17:06:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: kus Kusche Klaus <kus@keba.com>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <AAD6DA242BC63C488511C611BD51F36732321D@MAILIT.keba.co.at>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732321D@MAILIT.keba.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kus Kusche Klaus wrote:
>> What sort of numbers are you talking when you say several?
> 
> 
> I measured IDE delays just a few weeks ago.
> 
> We are talking about up to 100 ms. 

OK, thanks for the data point.

That kind of interrupts off time is not really acceptable to
anyone, be it real time or a server.

I guess nothing has been done about the problem because it is
a relatively rare setup (or not enough people complaining).
Send instant messages to your online friends http://au.messenger.yahoo.com 
