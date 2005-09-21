Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVIUWHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVIUWHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVIUWHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:07:19 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:21240 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965104AbVIUWHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:07:18 -0400
Message-ID: <4331D997.70603@namesys.com>
Date: Wed, 21 Sep 2005 15:07:19 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl>	<43304AF2.8080404@namesys.com>	<17200.21620.684685.966054@gargle.gargle.HOWL>	<4331CDC2.1080300@namesys.com> <17201.53892.148162.340378@gargle.gargle.HOWL>
In-Reply-To: <17201.53892.148162.340378@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
>
>[...]
>
> > >
> > Yes, and one can compensate for them  fairly cleanly.  I can't say more
> > without the customer releasing the code first.
>
>That's the point: text-book algorithms are usually useless as is. They
>need adjustments and changes to work in real life.
>
>Nikita.
>
>
>  
>
Yes, but you want to understand the textbook algorithms first before you
tweak. If you don't understand why least block number first is inferior
to real elevator.....

There is value to reading the classics of literature, even though they
are always simplistic compared to real life.

Hans
