Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWCVLLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWCVLLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWCVLLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:11:47 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:27216 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750703AbWCVLLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:11:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=c1qda96D8naUqngXpfwxfbG0yKkBfsHzOimhWtkLtoM9D24BLBCr38OaxoBXV9FLRwpzIHh6mcPoW+e+lx+hU20TwIBbSx5sox5h90xB2XJq+X56O26QOcu+sASWDxg3bOb8yFNVC3L6R+O1qjcuEvfmaqTPPBicIhBK/e+uZO4=  ;
Message-ID: <44212353.7000408@yahoo.com.au>
Date: Wed, 22 Mar 2006 21:13:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>	 <441FEFB4.6050700@yahoo.com.au>	 <bc56f2f0603210803l28145c7dj@mail.gmail.com>	 <44209A26.3040102@yahoo.com.au> <bc56f2f0603220059x6b2a30b8h@mail.gmail.com>
In-Reply-To: <bc56f2f0603220059x6b2a30b8h@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> 2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:

> 
> We didnt wire them.
> 

But your comment said they were wired.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
