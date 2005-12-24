Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbVLXD00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVLXD00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 22:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVLXD00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 22:26:26 -0500
Received: from mail.shareable.org ([81.29.64.88]:20453 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1161160AbVLXD0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 22:26:25 -0500
Date: Sat, 24 Dec 2005 03:25:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@quelen.inf.utfsm.cl>
Cc: Scott Mansfield <thephantom@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       Ben Slusky <sluskyb@paranoiacs.org>,
       "Robert W. Fuller" <garbageout@sbcglobal.net>,
       linux-fsdevel@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20051224032540.GA3698@mail.shareable.org>
References: <thephantom@mac.com> <43AC5B14.2090509@mac.com> <200512240148.jBO1mlqx022718@quelen.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512240148.jBO1mlqx022718@quelen.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> > >>Developer replies that the source code will be provided
> > >>only to paying customers:
> 
> > > Not really.  Developer does make the bizarre statement that "paid
> > > customers" are entitled to source code,
> 
> Read the GPL: You get the binary, you are entitled to the source. You have
> no binary, wellll...
> 
> Sure, you can get the binary (legally!) from somebody else, and then you
> are entitled to source.

If in the last paragraph mean "then you are entitled to the source
[from Developer]", then that is not correct.

You are entitled to the source from the person who gave you the
binary.  You are also only entitled to it in ways enumerated by the
GPL - i.e. at the same time as you receive the binary, or if the
person giving the binary does not provide the source at the same time,
in the form of a 3 year written offer to provide it later from that
person.

If you receive a binary from an intermediate 3rd party, you have no
entitlement to get the source from _their_ supplier.  Only from the
3rd party.

If the 3rd party don't supply you with source, even if _they_ can't
because they don't have it, then _they_ are in breach of the GPL when
they give you the binary.

Of course, the upstream Developer could give you the source anyway.
But they aren't required to do that, if they aren't providing the binary.

All that said, isn't this thread a result of the upstream Developer
(i.e. not a 3rd party) providing binaries for free, and then not
providing source to the people who get those free binaries, despite
saying they will?  That is not on.

-- Jamie
