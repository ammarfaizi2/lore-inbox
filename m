Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLPCJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLPCJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVLPCJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:09:51 -0500
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:60793 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932073AbVLPCJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:09:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qoxxwq8UqmaUNSaMMNEqzEU6eJ0ctn4pD5YsucobqdHAyz/RRL+mcsfkwZ9it+cHh8goMVlN3bnPPbtX/RIsRmrFTxHisx6btnmiL08LJsp0l1+GY5Do8uNd8Kl3G6GJQOfKtLPvO10onnxCigYHeS1FplmKGZj6IFCjHG0P2dg=  ;
Message-ID: <43A221E9.8040505@yahoo.com.au>
Date: Fri, 16 Dec 2005 13:09:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Helge Hafting <helge.hafting@aitel.hist.no>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512150013.29549.a1426z@gawab.com> <200512151131.39216.a1426z@gawab.com> <43A1501F.5070803@aitel.hist.no> <200512152129.01861.a1426z@gawab.com>
In-Reply-To: <200512152129.01861.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
>>Disadvantages of a stable API:
>>* It encourages binary-only drivers, while we prefer source drivers.
>>   Changing the API often and without warning is one way of
>>   hampering binary-only driver development without harming
>>   open-source drivers.
> 
> 
> You are really shooting yourself in the foot here.
> 

Replying to different people in the same email gets confusing.


> Don't mistake scalability for manageability/mantainability or flexibility.  
> Scalability is more, much more.  It's about extendability and reusability 
> built on a solid foundation that may be stacked.  Layers upon layers, the 
> sky is the limit.  Stability is the key to unlock this scalability.
> 

You're just completely making that all up with no reasons or basis.
What's more it doesn't even mean anything. It is quite obvious that
you have zero real arguments as to why a stable API is good. So let's
just leave it at that.

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
