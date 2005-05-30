Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVE3Knu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVE3Knu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVE3Knt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:43:49 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:27061 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261401AbVE3KnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:43:16 -0400
Message-ID: <429AEE3A.5080803@yahoo.com.au>
Date: Mon, 30 May 2005 20:43:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: kus Kusche Klaus <kus@keba.com>
CC: James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <AAD6DA242BC63C488511C611BD51F367323224@MAILIT.keba.co.at>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323224@MAILIT.keba.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kus Kusche Klaus wrote:

>>You don't explain how making the Linux kernel hard-RT
>>will be so much simpler and more supportable!
> 
> 
> I didn't state that a hard-RT linux is simpler, technically 
> (however, personally, I believe that once RT linux is there, *our*
> job of writing RT applications, device drivers, ... will be simpler
> compared to a nanokernel approach).
> 

Perhaps very slightly simpler. Let's keep in mind that we're
not talking about "hello, world" apps here though, so I don't
think such a general statement is of any use.

> I just stated that for the management, with its limited interest and
> understanding of deep technical details (and, in our case, with bad 
> experiences with RT plus non-RT OS solutions), a one-system solution
> *sounds* much simpler, easier to understand, and easier to manage.
> 

So does Windows NT to some. But let's stick to technical details.

> Decisions in companies aren't based on purely technical facts,
> sometimes not even on rational arguments...
> 
> And concerning support:

[...]

> Hence, w.r.t. support, the nanokernel approach looks much worse. 
> 

Gee, I think you're treading very thin ground there. Basing your
argument on what possible companies or communities might possibly
support one of two unimplemented solutions.

What's more, there is no reason why a hard-RT guest kernel, or the
host nanokernel would be closed source.

Send instant messages to your online friends http://au.messenger.yahoo.com 
