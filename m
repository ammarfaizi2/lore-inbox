Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVBDWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVBDWLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbVBDWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:06:54 -0500
Received: from sd291.sivit.org ([194.146.225.122]:35050 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S266482AbVBDVxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:53:24 -0500
Date: Fri, 4 Feb 2005 22:53:20 +0100
From: Stelian Pop <stelian@popies.net>
To: Roland Dreier <roland@topspin.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204215320.GE29712@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Roland Dreier <roland@topspin.com>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <52fz0c9twn.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fz0c9twn.fsf@topspin.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 08:22:48AM -0800, Roland Dreier wrote:

> I don't pretend to understand all the tools or where information is
> being lost, but I did use Stelian's HOWTO to make a subversion kernel
> tree last night.  I'm including log information for what happen to be
> the two most recent subversion changesets in my tree.  I think we can
> all agree that quite a bit of useful information is lost to users of
> the subversion tree.
> 
> ------------------------------------------------------------------------
> r26549 | torvalds | 2005-01-31 07:47:51 -0800 (Mon, 31 Jan 2005) | 208 lines
> 
> Merge bk://linux-acpi.bkbits.net/to-linus
> into ppc970.osdl.org:/home/torvalds/v2.6/linux

[ ... very long list merged changesets skipped ... ]

> 2005/01/04 22:57:14-05:00 len.brown
> Merge intel.com:/home/lenb/bk/linux-2.6.10
> into intel.com:/home/lenb/src/26-stable-dev
> 
> BKrev: 41fe5327BXOmplstrv49I26qAg7mIA

By the way Larry, wasn't the BKrev supposed to help with finding
the changesets on bkbits ?

Because I'm not sure if it works anymore (or how it is supposed to
work).

For example:

http://linux.bkbits.net:8080/linux-2.6/cset@41fe5327BXOmplstrv49I26qAg7mIA

gives only the merge changeset, obviously not the same as the above
revision.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
