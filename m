Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbUJZBI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUJZBI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUJZBI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:08:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261848AbUJZBIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:08:30 -0400
Date: Mon, 25 Oct 2004 21:32:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Greg Buchholz <greg@sleepingsquirrel.org>
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041025213242.B3841@almesberger.net>
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com> <20041021213600.GB675@sleepingsquirrel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021213600.GB675@sleepingsquirrel.org>; from greg@sleepingsquirrel.org on Thu, Oct 21, 2004 at 02:36:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Buchholz wrote:
>     Yeah, that's probably the catch, because I'd want to use gvs (GNU
> verilog/VHDL synthesis ;)

Sigh. It's quite sad that we don't even seem to have the complete
toolchain to program a 16V8 (although the information seems to be
available), let alone *any* CPLD. Of course, a 16V8 isn't very sexy
these days, so what might be happening is that people don't care to
solve the easy problem, and thus miss the opportunity to develop
the ability to reverse-engineer the more complex parts.

Regarding the viability of such a product: I wouldn't dismiss brand
name recognition as a factor. If people recognize Tech Source as a
company that has enabled them to do things previously hidden behind
barriers, they may recognize that it is in their own best interest
to help you to continue doing this. Not all will, but enough might.

Another item: it would be good to decide early on a fixed date for
releasing the Verilog source. Or, make this two dates: an internal
one, when you'll put it on your agenda for consideration, and a
hard one, maybe half a year later, which you'll publish. You won't
release on the first deadline, but at least you'll know that you
have to work on getting the thing out, and if you have people who
are still trying to milk the technology, they have time to switch.

Also, by making it clear that the design will be released, you'll
avoid getting trapped by sublicenses. ("Oh, but we just licensed
the design for $$$ - we can't possibly open it now !")

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
