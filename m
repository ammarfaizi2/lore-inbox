Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVLVC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVLVC5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 21:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVLVC5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 21:57:55 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:13746 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965040AbVLVC5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 21:57:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IZ/olnohUlfugwfaTwXpGscmcSJTdj8ChfgH1gUtZSwe8mZS8vWVdCXsHERJwXr18m4EF6MwwUHo0ycKOpzFaUNFQrRZLigRWD6r4o10y1D+CflwJogh9FjhZ8y4frpIZca1f8q71+J6PM2LLbLnh5Sbol20ISUqR8ZfpmVFGRI=  ;
Message-ID: <43AA162C.3000905@yahoo.com.au>
Date: Thu, 22 Dec 2005 13:57:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Jes Sorensen <jes@trained-monkey.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net> <43AA1134.7090704@yahoo.com.au>
In-Reply-To: <43AA1134.7090704@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I wonder if you can record a maximum
> cost per op? That would be more interesting than either average or
> standard deviation.
> 

More interesting from a fairness point of view, I mean.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
