Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVDZEX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVDZEX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDZEXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:23:07 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:15299 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261324AbVDZEWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:22:42 -0400
Date: Mon, 25 Apr 2005 21:22:10 -0700 (PDT)
From: Andreas Gal <gal@uci.edu>
X-X-Sender: gal@sam.ics.uci.edu
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <20050426040933.GA21178@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504252117510.14838@sam.ics.uci.edu>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050426040933.GA21178@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If adding a new arch touches 1000+ files, you're doing something 
_very_ wrong. Plus, how often did that happen in the past 10 years? 
30 times?? Probably less.

Andreas

On Mon, 25 Apr 2005, Chris Wedgwood wrote:

> On Mon, Apr 25, 2005 at 07:08:28PM -0700, Linus Torvalds wrote:
> 
> > If you're checking in a change to 1000+ files, you're doing
> > something wrong.
> 
> arch or subsystem merge?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
