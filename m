Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSJMQNK>; Sun, 13 Oct 2002 12:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJMQNK>; Sun, 13 Oct 2002 12:13:10 -0400
Received: from [203.117.131.12] ([203.117.131.12]:7848 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261271AbSJMQNJ>; Sun, 13 Oct 2002 12:13:09 -0400
Message-ID: <3DA99CEC.8040208@metaparadigm.com>
Date: Mon, 14 Oct 2002 00:18:52 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/02 23:35, Christoph Hellwig wrote:
> _I_ don't want to get EVMS in, sorry.

You've made your intentions crystal clear. Lucky you're not the
one you decides. At the end of the day it is just another 'driver'
and I don't think it's fair to place a higher benchmark of quality
on EVMS than all the other drivers in the kernel (although your
criticism does serve as a good way of disguising your motives of
blocking its inclusion).

We all know you 'you can't please all of the people all of the time'
and its always the dissenters who have the loudest voice.

 > I _do_ want a proper volume managment framework, but I can live with
 > it not beeing in before 2.8.

Some of us have large arrays and SANs where the absence a volume
manager is a big thing. I'm glad to see the distros picking it up
- i guess they have customers who need this sort of stuff.

How about feedback from other kernel developers on EVMS. Does anyone
think 'its good enough for inclusion now as long as a few cleanups
are done after the freeze'?

~mc

