Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSKLWcn>; Tue, 12 Nov 2002 17:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266993AbSKLWcn>; Tue, 12 Nov 2002 17:32:43 -0500
Received: from webmail.topspin.com ([12.162.17.3]:30307 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S266955AbSKLWcl>; Tue, 12 Nov 2002 17:32:41 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
References: <521y5qn7l5.fsf@topspin.com>
	<1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
	<52adkele4l.fsf@topspin.com>
	<20021112.143143.100089039.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Nov 2002 14:39:31 -0800
In-Reply-To: <20021112.143143.100089039.davem@redhat.com>
Message-ID: <521y5ql8f0.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Nov 2002 22:39:27.0484 (UTC) FILETIME=[5B8613C0:01C28A9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    Roland> if I wrote a patch to do this would you accept it?  (And
    Roland> following that increase MAX_ADDR_LEN?)

    David> I would have to see it first, but likely yes.

Of course, that's what I would expect.  (And I expect to go through a
few revisions before it's good enough)  I just don't want to start on
something that you think is categorically a stupid idea.

I will code up the rtnetlink extensions I proposed and post them when
they are ready.

Thanks,
  Roland
