Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbSKTETZ>; Tue, 19 Nov 2002 23:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKTETY>; Tue, 19 Nov 2002 23:19:24 -0500
Received: from willow.seitz.com ([146.145.147.180]:44049 "EHLO
	willow.seitz.com") by vger.kernel.org with ESMTP id <S265732AbSKTETY>;
	Tue, 19 Nov 2002 23:19:24 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Tue, 19 Nov 2002 23:26:24 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021120042624.GA21122@willow.seitz.com>
References: <Pine.LNX.4.44.0211192036530.30881-100000@blessed.joshisanerd.com> <Pine.LNX.4.44L.0211200057370.4103-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211200057370.4103-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:59:26AM -0200, Rik van Riel wrote:
> You can copyright songs, but not individual musical notes.
> 
> Likewise, snippets of code aren't copyrightable if they're below
> a certain "triviality size".

I don't pretend to be current on all the issues involved, but I've
always been under the impression that Linus has insisted that
binary-only drivers aren't derived works, with respect to the GPL.

If someone is worried they are, make all future headers state it
explicitly:

"Including this header in a Linux kernel module shall not be construed
to constitute a derived work."

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.      It is a Cannon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
