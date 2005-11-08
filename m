Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVKHBqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVKHBqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVKHBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:46:35 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:29886 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965163AbVKHBqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:46:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IRv2NSAhUkEFn3M7xpEbI13DeSnfSRmTqayowg73J85O7OJScaG1ifdVptBS/SaQ6Hh08tr1qMj44dDwsH4qmbpnnirJFUzOE6il/h24fz+AMENj6LU3uL0xY7VigavomxzPR3XZ2tSKlo+NB/4xT6sMeWH2ktmvGO8ykpyRA9g=  ;
Message-ID: <437003DC.4080500@yahoo.com.au>
Date: Tue, 08 Nov 2005 12:48:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Anton Blanchard <anton@samba.org>, Brian Twichell <tbrian@us.ibm.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay> <43700371.6040507@yahoo.com.au>
In-Reply-To: <43700371.6040507@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

[...]

> be some at least small regressions. Have you seen any? Do you have
> any tests in mind that might show a problem?
> 

To clarify, I'm not suggesting you should go one way or the other
for POWER4/5, but if you did have regressions I would be interested
at least so I can try helping platforms that do use balance on clone.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
