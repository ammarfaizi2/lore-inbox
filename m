Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVIUVg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVIUVg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVIUVg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:36:59 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:31447 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965006AbVIUVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:36:58 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17201.53892.148162.340378@gargle.gargle.HOWL>
Date: Thu, 22 Sep 2005 01:37:08 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <4331CDC2.1080300@namesys.com>
References: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl>
	<43304AF2.8080404@namesys.com>
	<17200.21620.684685.966054@gargle.gargle.HOWL>
	<4331CDC2.1080300@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

[...]

 > >
 > Yes, and one can compensate for them  fairly cleanly.  I can't say more
 > without the customer releasing the code first.

That's the point: text-book algorithms are usually useless as is. They
need adjustments and changes to work in real life.

Nikita.
