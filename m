Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbSJNOPz>; Mon, 14 Oct 2002 10:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSJNOPy>; Mon, 14 Oct 2002 10:15:54 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:46774 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261629AbSJNOPv>; Mon, 14 Oct 2002 10:15:51 -0400
Date: Mon, 14 Oct 2002 09:20:48 -0500
From: Shawn <core@enodev.com>
To: Christoph Hellwig <hch@infradead.org>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014092048.A27417@q.mn.rr.com>
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021013163551.A18184@infradead.org>; from hch@infradead.org on Sun, Oct 13, 2002 at 04:35:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13, Christoph Hellwig said something like:
> On Sun, Oct 13, 2002 at 11:16:24PM +0800, Michael Clark wrote:
> > On 10/13/02 21:49, Christoph Hellwig wrote:
> > > On Sun, Oct 13, 2002 at 08:41:20PM +0800, Michael Clark wrote:
> _I_ don't want to get EVMS in, sorry.  I _do_ want a proper volume
> managment framework, but I can live with it not beeing in before 2.8.

I think this is where you're going to get the most disagreement.

It was included in mainline, then it just goes away? Linus has no
obligation at all to include anything, but a lot of people depend
on it.

Yeah yeah, distros can include it at will, but mainline inclusion is the
best way to get large exposure and testing to the thing.

Having said all that, given that your premises are true regarding the
code design problems you have with EVMS, you have a valid point about
including it in mainline. The question is, is this good enough to ignore
having a logical device management system?!?

--
Shawn Leas
core@enodev.com

I put my air conditioner in backwards.  It got cold outside.
The weatherman on TV was confused.  "It was supposed to be hot
today."
						-- Stephen Wright
