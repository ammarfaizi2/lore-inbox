Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272315AbRH3QbX>; Thu, 30 Aug 2001 12:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272321AbRH3QbN>; Thu, 30 Aug 2001 12:31:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:60796 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272315AbRH3Qa5>; Thu, 30 Aug 2001 12:30:57 -0400
Date: Thu, 30 Aug 2001 12:31:12 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ion Badulescu <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108301227080.12593-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Linus Torvalds wrote:

> And not getting surprisied is a good thing.

Most of us don't really care about the details of the whole min/max thing
(my only real care is that it should've been called anything other than
min or max, typed_min perhaps, but that's a secondary issue, more relevant
to forwards compatibility of 2.4/2.2/2.0 hybrid drivers).  What we do care
about is the fact that a release was done without a prepatch to look over
to give people a chance to fix any resulting breakage.

		-ben

