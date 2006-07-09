Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWGIRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWGIRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWGIRFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:05:24 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:20884 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964880AbWGIRFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:05:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zxi0RV7aoTflwfNkJWOw6CBIO0uAwn9m4q2CTtQmh+HXWAtuy0CbsynscKOrCdpme3ilH0oqLz52zNLJBlrUBrexEPohrcj+eEOo08hxm2rhW+qVcM8/UzGO3hMYo6vrZfqeahe3w+gUXqZJlH9S1RuM+JtfQd62MCcfY37AgXE=  ;
Message-ID: <44B11D99.5090303@yahoo.com.au>
Date: Mon, 10 Jul 2006 01:15:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Abu M. Muttalib" <abum@aftek.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>,
       chase.venters@clientec.com, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
References: <BKEKJNIHLJDCFGDBOHGMIEFJDCAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMIEFJDCAA.abum@aftek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
>>Abu, I guess you have turned on CONFIG_EMBEDDED and disabled everything
>>you don't need, turned off full sized data structures, removed everything
>>else you don't need from the kernel config, turned off kernel debugging
>>(especially slab debugging).
> 
> 
> Do you mean that I have configured kernel with CONFIG_EMBEDDED option??

I am guessing you have, if you a concerned about memory usage. Have you?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
