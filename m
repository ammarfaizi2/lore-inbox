Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVCGFmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVCGFmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCGFmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:42:25 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:64940 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261632AbVCGFmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:42:14 -0500
Message-ID: <422BE9B2.2080604@yahoo.com.au>
Date: Mon, 07 Mar 2005 16:42:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Ben Greear <greearb@candelatech.com>,
       Christian Schmid <webmaster@rapidforum.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <20050307053032.GA30052@alpha.home.local> <422BE96E.9040006@yahoo.com.au>
In-Reply-To: <422BE96E.9040006@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Willy Tarreau wrote:


>> thousands of sockets). I never had enough time to investigate more, so I
>> went back to 2.4.
>>
> 
> I have heard other complaints about this, and they are definitely
> related to the scheduler (not saying yours is, but it is very possible).
> 

Oh, and if you could dig this thing up too, that might be
good: someone else may have time to investigate more.

Thanks.

