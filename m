Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272126AbTHDSwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272135AbTHDSwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:52:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54145 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272126AbTHDSvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:51:09 -0400
Date: Mon, 4 Aug 2003 11:45:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-Id: <20030804114546.10786f84.davem@redhat.com>
In-Reply-To: <16174.43161.252794.244789@napali.hpl.hp.com>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<20030804113144.47fcc112.davem@redhat.com>
	<16174.43161.252794.244789@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 11:40:25 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> For what it's worth, I spend on average about 1 day a week on ia64
> linux maintenance and that's just about as much as I'd want to (though
> in recent months it has been a bit more, partly so that we can get
> into sync with Linus' tree).

I'm not addressing you specifically, but I will note how great
you tend to say ia64 is when platform performance comparison
discussions happen on the lists :-)

In general, I think some platform maintainence drifts way too easily
into a tail-spin of local changes that take forever to get merged.

My point was that if some random single monkey like me can keep a
loser platform like sparc64 still building in Linus's tree, a group of
several trained professionals should be able to fare much better :)

