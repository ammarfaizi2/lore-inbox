Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWC1LQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWC1LQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWC1LQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:16:58 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:27293 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932177AbWC1LQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:16:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bi+NNhaH6b4+8Y2oPQfMJXs+XEnN10y8pB8s+1yCadwW5WmiyFDrxMo4zAEygKO6zTOxFL4aoly4Kw5kR6lYjh1hZvuh0fQ1wpI5LeiXED9sAHhmo5jM/BJO5gvk3fELHWBQWKO5tMgoWzomCbjOjjXunAtFYkkx3OGSU458hh8=  ;
Message-ID: <4428FB29.8020402@yahoo.com.au>
Date: Tue, 28 Mar 2006 19:00:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>
In-Reply-To: <20060328085206.GA14089@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

> well, that largely depends on the 'use' ...
> 
> I don't think that vps providers like lycos would be
> very happy if they had to multiply the ammount of
> machines they require by 10 or 20 :)
> 
> and yes, running 100 and more Linux-VServers on a
> single machine _is_ realistic ...
> 

Yep.

And if it is intrusive to the core kernel, then as always we have
to try to evaluate the question "is it worth it"? How many people
want it and what alternatives do they have (eg. maintaining
seperate patches, using another approach), what are the costs,
complexities, to other users and developers etc.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
