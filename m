Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUCMTXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUCMTXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:23:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47830 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263169AbUCMTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:23:04 -0500
Date: Sat, 13 Mar 2004 13:36:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040313123620.GA3352@openzaurus.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079146273.1967.63.camel@gaston>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> > complaint about it is that since it's maintained outside of the
> > kernel, it's constantly behind about 0.75 revisions behind the latest
> > 2.6 release.  The feature set of swsusp2, if they can ever get it
> > completely bugfree(tm) is certainly impressive.
> 
> I'd like it to be merged upstream too.

Are we talking 2.6 or 2.7 here?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

