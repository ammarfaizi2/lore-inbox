Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266593AbUBQVKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUBQVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:08:55 -0500
Received: from mho.net ([64.58.22.195]:55263 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S266603AbUBQVH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:07:29 -0500
Date: Tue, 17 Feb 2004 14:06:21 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@sm1420.belits.com
To: Jamie Lokier <jamie@shareable.org>
cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <20040217205707.GF24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
 <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide>
 <20040217205707.GF24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Jamie Lokier wrote:

> No, I think hacking the terminal I/O is the best bet here.  Then _all_
> programs which currently work with UTF-8 terminals, which is rapidly
> becoming most of them, will work the same with both kinds of terminal,
> and the illusion of perfection will be complete and beautiful.

  UTF-8 terminals (and variable-encoding terminals) alreay exist,
gnome-terminal is one of them. They are, of course, bloated pigs, but I
would rather have the bloat and idiosyncrasy in the user interface where
it belongs.

-- 
Alex
