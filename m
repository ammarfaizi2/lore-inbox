Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWDYI2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDYI2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDYI2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:28:13 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:54145 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751427AbWDYI2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:28:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=a+gev0eSG63Wc1x3CUG2ZveDxkThvcCAtfa2sAjvbp9eU/Vut5iiATEZDYTw8yy4vFAM3FiYNu65KYeMy4D2+2Zphv3m7+hJFDATkSswkOww++/IbxIXjsUW/yGPAQ9wRlzUyL9/Jqej8aRpKxduqwHpJsfYDdkS5CkcQQEpioQ=  ;
Message-ID: <444DD3F6.70108@yahoo.com.au>
Date: Tue, 25 Apr 2006 17:47:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz> <444DD0E7.5070005@argo.co.il>
In-Reply-To: <444DD0E7.5070005@argo.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> [original poster de-cc'ed]
> 
> Martin Mares wrote:
> 
>> Can you name any reasons for why should we support C++ in the kernel?
>>   
> 
> 1. Porting existing modules written in C++ - the trigger for this thread?
> 
> 2. Shorter, faster, more robust code.
> 
>> Why shouldn't we invest the effort to making it possible to write kernel
>> modules in Haskell instead?
>>   
> 
> C++ is a system programming language with good C compatibility. Making 
> the kernel compatible with C++ is doable.

You could call it Linux++ and discuss it to your heart's content in l++kml ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
