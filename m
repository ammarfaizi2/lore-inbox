Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWEBKfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWEBKfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWEBKfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:35:48 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:62109 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932145AbWEBKfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:35:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qfVZFZh7+zZw8OVHhaTl8VqmN5ujkbQNbXx9CK+PjwVWb8PWyzLlVpAB5utujwKpTc8z68jdMN6teaMZV4UMOTJy4LhnCNpv0HxG9RmGWUoz0Xe2A/IMtTDRVEsRBaw1SXwRV5omiUxxhWhyrPfj5xpzG4qH7HelT3JJe/4rxwU=  ;
Message-ID: <4456D85E.6020403@yahoo.com.au>
Date: Tue, 02 May 2006 13:56:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: blaisorblade@yahoo.it
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au>
In-Reply-To: <4456D5ED.2040202@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> blaisorblade@yahoo.it wrote:
> 
>> The first idea is to use this for UML - it must create a lot of single 
>> page
>> mappings, and managing them through separate VMAs is slow.

[...]

> Let's try get back to the good old days when people actually reported
> their bugs (togther will *real* numbers) to the mailing lists. That way,
> everybody gets to think about and discuss the problem.

Speaking of which, let's see some numbers for UML -- performance
and memory. I don't doubt your claims, but I (and others) would be
interested to see.

Thanks

PS. I'll be away for the next few days.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
