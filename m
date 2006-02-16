Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWBPFYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWBPFYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBPFYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:24:20 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:14958 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932177AbWBPFYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:24:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=477PmId02NNZH9oFYhGoioC2jZMKQoK5/JHt7Wn1OsapZZB2YZNsjgWmIuDAMCFmCIhMMJSa4gzyKeSSNY+oibkYIaur11fsxspiMDqVJNOrF8/+zcMVnkrpJYEzNtLSto1iWdnPYciKHDGWVzEV76ubYFsQl2H7TQ9wZsiBXrQ=  ;
Message-ID: <43F408B7.8080408@yahoo.com.au>
Date: Thu, 16 Feb 2006 16:08:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Possibly bug in radix_tree_delete, and fix.
References: <17395.58244.839605.685011@cse.unsw.edu.au>	<43F3EE8F.8060000@yahoo.com.au> <20060215195541.6a3acd67.akpm@osdl.org>
In-Reply-To: <20060215195541.6a3acd67.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Not sure why it didn't trigger Andrew's test suite, but I guess that's
>>something to add.
> 
> 
> Could you please do so?  And add in the previous enhancements you made?  I
> was never able to sort out the patches you sent.  And test Neil's later
> patch (which looks OK to me)?
> 

I will do so, give me a few minutes.

I don't think the patches I sent before would look any different now
(actually I'm quite sure I haven't made any new changes), so I'm not
sure if there would be any point, would there?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
