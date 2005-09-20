Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVITNzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVITNzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVITNzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:55:43 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:47065 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965016AbVITNzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:55:42 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17200.5343.908617.558388@gargle.gargle.HOWL>
Date: Tue, 20 Sep 2005 17:55:43 +0400
To: Lorenzo Allegrucci <l.allegrucci@gmail.com>
Cc: Hans Reiser <reiser@namesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <200509201530.01808.l.allegrucci@gmail.com>
References: <200509180934.50789.chriswhite@gentoo.org>
	<432FC150.9020807@namesys.com>
	<20050920114253.GL10845@suse.de>
	<200509201530.01808.l.allegrucci@gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l.allegrucci@gmail.com> writes:

[...]

>
> Why not just rename the kernel option "elevator" to "iosched" ?

At least update Documentation/kernel-parameters.txt to be consistent,
but I think kernel boot options are considered to be a part of the "user
space API" and, as such, cannot be changed that easily.

Nikita.
