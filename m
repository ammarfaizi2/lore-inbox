Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUBQVsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUBQVsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:48:14 -0500
Received: from mail.shareable.org ([81.29.64.88]:12421 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266672AbUBQVrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:47:37 -0500
Date: Tue, 17 Feb 2004 21:47:33 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040217214733.GJ24311@mail.shareable.org>
References: <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide> <20040217205707.GF24311@mail.shareable.org> <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Belits wrote:
> > No, I think hacking the terminal I/O is the best bet here.  Then _all_
> > programs which currently work with UTF-8 terminals, which is rapidly
> > becoming most of them, will work the same with both kinds of terminal,
> > and the illusion of perfection will be complete and beautiful.
> 
>   UTF-8 terminals (and variable-encoding terminals) alreay exist,
> gnome-terminal is one of them. They are, of course, bloated pigs, but I
> would rather have the bloat and idiosyncrasy in the user interface where
> it belongs.

Yes, I am using it right now.  The fancy characters work well in it.
Problem is, sometimes I have to use a non-UTF-8 terminal, and I would
naturally like to access my files in the same way.

-- Jamie
