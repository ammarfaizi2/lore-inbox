Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267308AbUHEDGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267308AbUHEDGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 23:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHEDGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 23:06:16 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:45953 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267308AbUHEDGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 23:06:04 -0400
Message-ID: <4111A418.5030101@yahoo.com.au>
Date: Thu, 05 Aug 2004 13:06:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au> <411196EE.9050408@bigpond.net.au> <41119A3B.2020202@yahoo.com.au> <4111A39C.40200@bigpond.net.au>
In-Reply-To: <4111A39C.40200@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Nick Piggin wrote:
>
>> However if you add or remove scheduling policies, your
>> p->policy method breaks.
>
>
> Not if Albert's numbering system is used.
>

What if another realtime policy is added? Or one is removed?

