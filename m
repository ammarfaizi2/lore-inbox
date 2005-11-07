Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVKGEtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVKGEtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKGEtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:49:46 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:42632 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751186AbVKGEtp (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 23:49:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=binhhWiSvsuDvDncD0Q03aMgda3/2+nzl3OKAIoA+AmNOHPBBtMMfBERgpFJVu9k7Q0D0J+r/Bz9Qlhz9AAKj0B8i5zlppgQ4FGhMPk2YnoZJzkM5LNrccIVhXIApdRZmWJmpDjZs9w2Oq4cG5kYHHC7qz5IsaW9Rh6VgavUokA=  ;
Message-ID: <436EDD67.4000207@yahoo.com.au>
Date: Mon, 07 Nov 2005 15:51:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: hch@infradead.org, Linux-Kernel@vger.kernel.org
Subject: Re: [rfc][patch 0/14] mm: performance improvements
References: <436DBAC3.7090902@yahoo.com.au>	<20051107013900.GA9170@infradead.org>	<436EB326.3070006@yahoo.com.au> <20051106195750.5cf71820.pj@sgi.com>
In-Reply-To: <20051106195750.5cf71820.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>Maybe time to switch mailers... I'll see what I can do.
> 
> 
> I recommend using a dedicated tool (patchbomb script) to send patches,
> not ones email client.  It lets you prepare everything ahead of time in
> your favorite editor, and obtains optimum results.
> 
> See the script I use, at:
> 
>   http://www.speakeasy.org/~pj99/sgi/sendpatchset
> 

Probably the best idea. I hadn't worried about those until now,
although I have several fairly large patchsets floating around.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
