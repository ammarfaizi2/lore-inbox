Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUBWNYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUBWNXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:23:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60086 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261847AbUBWNXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:23:13 -0500
Date: Thu, 19 Feb 2004 23:33:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org,
       lm@bitmover.com
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040219223335.GG467@openzaurus.ucw.cz>
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <slrnc2ktre.4t9.erik@bender.home.hensema.net> <20040212134022.GC8705@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212134022.GC8705@louise.pinerecords.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> P.S.  It's also very nice to never have to fsck (that is unless
> a broken driver/hardware writes random crap directly to the block
> device).

You should force fsck once in a while. I did and there
were a nasty surprise for me...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

