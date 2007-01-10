Return-Path: <linux-kernel-owner+w=401wt.eu-S932774AbXAJMQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbXAJMQu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbXAJMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:16:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54073 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774AbXAJMQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:16:49 -0500
Date: Wed, 10 Jan 2007 15:14:09 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jamal Hadi Salim <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [take32 0/10] kevent: Generic event handling mechanism.
Message-ID: <20070110121409.GA28862@2ka.mipt.ru>
References: <11684170003907@2ka.mipt.ru> <45A4C9DE.8020605@garzik.org> <20070110113051.GA4950@2ka.mipt.ru> <45A4D478.2030200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45A4D478.2030200@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 10 Jan 2007 15:14:14 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:56:40AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> >It was there, but Andrew dropped it somewhere about take25 :)
> 
> Probably because it was a moving target with a high rate of change, 
> requiring time that Andrew did not have just to keep in sync and fix 
> build conflicts with other -mm patches.

Ok, I understood.
Let's freeze kevent for a while and allow things to settle down, but...

How can I detect that it is in use, since I get no feedback?
I suppose that if Andrew will not pick it up, I will resend/push/pull 
the latest set, but without new features implemented (or as addon), only
bugfixes.

> 	Jeff
> 

-- 
	Evgeniy Polyakov
