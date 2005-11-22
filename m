Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVKVJsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVKVJsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKVJsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:48:45 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:26797 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751298AbVKVJso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:48:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZpCHAxEoO1dqlchNJBf3+8D/hIBP4j/1uyjaR0Y4EAXySFNZsbimX+zkNwzGP2RlGUefOrGfczrxvBJB/6ftQw6JvLtHIgmjKjHv+EDJvWeyBzg+bJ0S1p5Gz7bNzexrbrxFfhECOysWpC/C/FL8m/MM8x2C05R5GqwqdsDHw7A=  ;
Message-ID: <4382F823.8010007@yahoo.com.au>
Date: Tue, 22 Nov 2005 21:51:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/12] mm: optimisations
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net> <20051122000620.4cad7ce6.akpm@osdl.org>
In-Reply-To: <20051122000620.4cad7ce6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>The following patchset against 2.6.15-rc2 contains optimisations to the
>> mm subsystem, mainly the page allocator.
> 
> 
> All look sane to me - I merged the ones which applied, randomly dropped the
> rest

Thanks, I'll resynch the remaining patches and send them in a bit.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
