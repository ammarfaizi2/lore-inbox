Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVIBGpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVIBGpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbVIBGpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:45:06 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:48530 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161007AbVIBGpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:45:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VlAe7IydsPwAYM/Trle8AJ/m5C1Xd7i4qrPjBHZWu0HN0mVlX6v6aBHeawhTYfV99aHf/NDabxLGviMTjPNGOy8WF4lZKAkcnCUYBiXPiCFrSliZk5Zd+4O6RHm7fM03wR2JHrXGRdpXKsznEuZzlUybaMJg3jkrkNU4Co0WXoY=  ;
Message-ID: <4317F50B.6080005@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:45:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New lockless pagecache
References: <4317F071.1070403@yahoo.com.au>
In-Reply-To: <4317F071.1070403@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I think this is getting pretty stable. No guarantees of course,
> but it would be great if anyone gave it a test.
> 

Or review, I might add. While I understand such a review is
still quite difficult, this code really is far less complex
than the previous lockless pagecache patches.

(Ignore 1/7 though, which is a rollup - a broken out patchset
can be provided on request)

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
