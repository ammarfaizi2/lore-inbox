Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUDVBa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUDVBa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 21:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUDVBa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 21:30:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263772AbUDVBaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 21:30:22 -0400
Date: Wed, 21 Apr 2004 21:30:12 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Miles Bader <miles@gnu.org>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Jan De Luyck <lkml@kcore.org>,
       <linux-kernel@vger.kernel.org>, <postmaster@vger.kernel.org>
Subject: Re: vger.kernel.org is listed by spamcop
In-Reply-To: <buollko4xjb.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0404212129510.17081-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2004, Miles Bader wrote:
> Rik van Riel <riel@redhat.com> writes:
> > I'm certain than vger got listed on spamcop due to linux-kernel
> > subscribers reporting to spamcop some of the spam that leaked onto
> > lkml, through Matti's strict filters.
> 
> Does that mean that spamcop does no verification of user reports?

Indeed.

> I was under the impression that it's fairly easy to automatically check
> whether a particular host is an open-relay or not, so it would seem kind
> of irresponsible for spamcop not to do this if some people are relying
> on their lists to do blocking (even if there's a disclaimer saying not
> to do that, clearly people are ignorant or dumb, so why not play it safe?).

Spamcop isn't doing any vulnerability checks I'm aware of.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

