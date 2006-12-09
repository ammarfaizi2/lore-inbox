Return-Path: <linux-kernel-owner+w=401wt.eu-S1030627AbWLIMJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWLIMJ2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWLIMJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:09:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46412 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030627AbWLIMJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:09:26 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 07:05:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
In-Reply-To: <1165663793.1103.127.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612090656140.13654@localhost.localdomain>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
 <1165663793.1103.127.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Benjamin Herrenschmidt wrote:

> > p.s.  it's possible that this is all just a wild coincidence, of
> > course.  stranger things have happened.
>
>  ... or a genuine mistake.

sure, as i wrote above, i'm willing to accept that.  but it still
leaves an open issue -- once one submits a patch, is there *any*
official feedback that one can look for to see if it's been
accepted/rejected/dropped on the floor/whatever?

at last count, i have eight patches in the queue.  or do i?  i have no
way of knowing.  (actually, that's not entirely true -- one of the
patches was Ack'ed so i'm assuming it will go in eventually, but i
still have no idea when.)

but given that i'm trying to follow the kernel guidelines and keep
each submission as a logically-related chunk, in many cases, i have to
wait for one patch to be applied before i can submit the next one.
and, at the moment, there's no way of knowing what's going on.

rday

p.s.  WRT to the example i described above, if it was a coincidence
that someone else submitted a duplicate patch to mine, i don't think
it's unreasonable to suggest that my submission should have been
replied to on the list with something like "this patch is a duplicate
of so-and-so's," rather than silently throwing it away.

a few seconds of that kind of courtesy seems a small price to pay to
let me avoid days of wondering what's happening.
