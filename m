Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSJNVnm>; Mon, 14 Oct 2002 17:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVnl>; Mon, 14 Oct 2002 17:43:41 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:8144 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262181AbSJNVnk> convert rfc822-to-8bit; Mon, 14 Oct 2002 17:43:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Christoph Hellwig <hch@infradead.org>, Shawn <core@enodev.com>
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Date: Mon, 14 Oct 2002 23:48:29 +0200
User-Agent: KMail/1.4.3
Cc: Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <20021014092048.A27417@q.mn.rr.com> <20021014172137.D19897@infradead.org>
In-Reply-To: <20021014172137.D19897@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210142348.29628.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Oktober 2002 18:21 schrieb Christoph Hellwig:
> On Mon, Oct 14, 2002 at 09:20:48AM -0500, Shawn wrote:
> > Having said all that, given that your premises are true regarding the
> > code design problems you have with EVMS, you have a valid point about
> > including it in mainline. The question is, is this good enough to ignore
> > having a logical device management system?!?
>
> It is not good enough to ignore it.  It is good enough to postpone
> integration for 2.7.

No, that is not an option. Either evms or lvm2 it must be.
Switching later might be difficult. So it has to be decided
quite soon.

	Regards
		Oliver

