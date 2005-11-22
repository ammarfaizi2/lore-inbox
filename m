Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVKUXXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVKUXXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVKUXXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:23:44 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:44945 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964772AbVKUXXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:23:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iK0hFgwgSBmFY89xbRWumI633dozlCevW85en16O4Sno717EOiSKIWX8rhmT3KlHHW2916K/yPcNb/P8Gz96djOxUBksVpC1R7WVV3ttgH5cAw9A7qC/MPU9Jrv1N9m1eaKEo5IXgqtWEJIAzNhAk8Z0IE3HNO6rBnx8u3qIwk8=  ;
Message-ID: <438265A7.8040602@yahoo.com.au>
Date: Tue, 22 Nov 2005 11:26:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 0/12] mm: optimisations
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net> <20051121062937.7f1a11a7.pj@sgi.com>
In-Reply-To: <20051121062937.7f1a11a7.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Welcome to sendpatchset - cool.
> 
> (Nick is now using sendpatchset:
>     http://www.speakeasy.org/~pj99/sgi/sendpatchset
>  to send these patches, so they are inline.)
> 
> Now ... if you use sendpatchset to send the entire set at once, and
> (even fancier) number them "01/12" instead of "1/12", we will see these
> patches in the order you numbered them, instead of in the order you
> apparently sent them: 11, 7, 8, 9, 12, 4, 2, 1, 5, 10 (with 3 and 6
> still outstanding).
> 

Yeah, they were, but it seems the smtp server's had a failure
and had to retry them.

Not the fault of your script though - it's nice. Thanks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
