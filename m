Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268709AbTCCSoS>; Mon, 3 Mar 2003 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268710AbTCCSoS>; Mon, 3 Mar 2003 13:44:18 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:2058 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268709AbTCCSnM>; Mon, 3 Mar 2003 13:43:12 -0500
Date: Mon, 3 Mar 2003 18:53:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk menuconfig format problem
Message-ID: <20030303185337.A30585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomas Szepe <szepe@pinerecords.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org> <20030303184906.GF6946@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303184906.GF6946@louise.pinerecords.com>; from szepe@pinerecords.com on Mon, Mar 03, 2003 at 07:49:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:49:06PM +0100, Tomas Szepe wrote:
> > On Mon, Mar 03, 2003 at 03:15:34PM +0000, Andrew Walrond wrote:
> > > Just done a pull and now the first entry of make menuconfig is:
> > > 
> > >   [*] Support for paging of anonymous memory
> > > 
> > > It shouldn't really be there, should it?
> > 
> > Why not?  Even if you never want to use a swapless kernel there's still
> > plenty use for it.
> 
> Andrew probably means the problem is in _where_ the entry shows up in
> menuconfig (and he's right).  I believe he didn't mean to question the
> existence of the option.

Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
on it's placements.  If people who actually do use if feel that it's placed
wrongly feel free to submit a patch to fix it.

