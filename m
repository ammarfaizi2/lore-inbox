Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbVCKE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbVCKE75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVCKE74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:59:56 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:41918 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263127AbVCKE7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:59:44 -0500
Message-ID: <4231258C.3060400@nortel.com>
Date: Thu, 10 Mar 2005 22:58:52 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
References: <20050309072833.GA18878@kroah.com>	<16944.6867.858907.990990@cse.unsw.edu.au>	<1110449872.6291.64.camel@laptopd505.fenrus.org> <16944.63807.579725.848224@cse.unsw.edu.au>
In-Reply-To: <16944.63807.579725.848224@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> If a data corruption bug has been there for 10 weeks without being
> noticed, then the real risk is not that great.  We are calling it
> "-release", not "-hardened".

I disagree.  If there's a simple, obvious, small fix that passes all the 
other criteria, it should go into -stable ASAP after passing review. 
Then the -stable maintainers will push the fix to Andrew/Linux, and it 
will go into the next 2.6.x.

Let's keep -stable as good as possible, while still abiding by all the 
other rules.

Chris
