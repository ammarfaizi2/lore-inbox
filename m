Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTKHSQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTKHSQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:16:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3719 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261916AbTKHSQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:16:31 -0500
Date: Sat, 8 Nov 2003 18:16:26 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ragnar Hojland Espinosa <ragnar@linalco.com>,
       Bill Davidsen <davidsen@tmr.com>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031108181626.GD7665@parcelfarce.linux.theplanet.co.uk>
References: <20031108150654.GA19980@linalco.com> <Pine.LNX.4.44.0311080950520.2787-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311080950520.2787-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 09:52:52AM -0800, Linus Torvalds wrote:
> 
> On Sat, 8 Nov 2003, Ragnar Hojland Espinosa wrote:
> > 
> > Well, I hope its in better state than the Mitsumi driver, because last
> > time I tried it was broken (oopsed in a simple cat) since a 2.3.xx
> > IIRC [0]
> 
> Since 2._3_.xx?
> 
> > [0]  Tracked it down to a -pre if anyone is interested and its still
> >      broken.. 
> 
> Quite frankly, if it's literally been broken since 2.3.x, I think the best 
> thing to do would be to remove the driver entirely.

... or give it to somebody on kernel-janitors and tell them to bring the
series of *provable* cleanups and fixes, getting the driver into decent
form.  Would be a good exercise.
