Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJWUJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJWUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8647 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261780AbTJWUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:13 -0400
Date: Thu, 23 Oct 2003 15:58:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nir Tzachar <tzachar@cs.bgu.ac.il>
Cc: Eric Sandall <eric@sandall.us>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
Message-ID: <20031023135850.GF643@openzaurus.ucw.cz>
References: <1066683638.3f944cf6e6763@horde.sandall.us> <Pine.LNX.4.44_heb2.09.0310211406170.8365-100000@nexus.cs.bgu.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44_heb2.09.0310211406170.8365-100000@nexus.cs.bgu.ac.il>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This sounds fairly similar to Coda[0], which is already in development and use.
> >
> 
> not at all.
> 
> coda is not self stabilizing at all.
> srfs is also a totally distributed file system -> see the doc.
> bye

Yes, but perhaps differences can be localized to userspace daemon,
having same kernel part for coda and srfs?
That would be *good*.

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

