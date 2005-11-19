Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVKSEbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVKSEbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKSEbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:31:06 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:12731 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751345AbVKSEbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:31:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yPyUSOkWUuHU2/Hoga6d872vxA+0vnfaerZaJvLmYVSHA3KsaP7+xLkUEUFNN4q+m9xI7vAkJHICvCCdHduYYxOGkZvGT7TKoeihjAlvdEiWOJ2vMZpaCy1EVpuSl8QYkEXR5f1SikESQ7rCjrJFrfzqb9rXHZvXoDa1LZntz2I=  ;
Message-ID: <437EAB1B.4090907@yahoo.com.au>
Date: Sat, 19 Nov 2005 15:33:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Hugh Dickins <hugh@veritas.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <20051118201203.GA31209@isilmar.linta.de> <200511182142.17432.rjw@sisk.pl> <437EAA83.6010808@yahoo.com.au>
In-Reply-To: <437EAA83.6010808@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> These look like they want the following patch. Does it help?
> 

Wait sorry, I was looking at an old kernel. Patch obviously won't
help.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
