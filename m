Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVLTIs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVLTIs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVLTIs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:48:56 -0500
Received: from smtp101.plus.mail.mud.yahoo.com ([68.142.206.234]:2466 "HELO
	smtp101.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750858AbVLTIsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:48:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tfRCiFjThDjClDL4iCSlRUV/XzXkK+dCWtGuZYEU+5qfDjmEquH7pq+UJfP7OFKODdnnGo8sohiangnh8faOhB3EOJC+No7rcGhB1VpT0WV/6E1UoFn+lHSGjzc2f5fb6YBi8aDuDa/19nQtE8OIKBQ1/JndULUfQPhSWbdN68A=  ;
Message-ID: <43A7C574.5030803@yahoo.com.au>
Date: Tue, 20 Dec 2005 19:48:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
References: <20051219013415.GA27658@elte.hu>	 <20051219042248.GG23384@wotan.suse.de>	 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>	 <20051219155010.GA7790@elte.hu>	 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>	 <20051219195553.GA14155@elte.hu>	 <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>	 <43A7BAB5.7020201@yahoo.com.au>	 <1135066007.2952.4.camel@laptopd505.fenrus.org>	 <43A7BEF6.3010202@yahoo.com.au> <1135067777.2952.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1135067777.2952.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-12-20 at 19:21 +1100, Nick Piggin wrote:

>>But I thought Linus phrased it as though mutex should be made
>>available and no large scale conversions.
> 
> 
> it's one at a time. Manual inspection etc etc
> and I don't expect 99% coverage, but the important 50% after 6 months or
> so...
> 

So long as there is a plan and movement, that is fine in my opinion.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
