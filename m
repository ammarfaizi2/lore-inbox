Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWACUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWACUhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWACUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:37:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932492AbWACUhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:37:47 -0500
Date: Tue, 3 Jan 2006 15:37:24 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: userspace breakage
Message-ID: <20060103203724.GG5819@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org> <20051229230307.GB24452@redhat.com> <20060103202853.GF12617@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103202853.GF12617@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 12:28:53PM -0800, Greg Kroah-Hartman wrote:

 > > I'm glad you agree.  I've decided to try something different once 2.6.16
 > > is out.  Every day, I'm going to push the -git snapshot of the day into
 > > a testing branch for Fedora users. (Normally, only rawhide[1] users 
 > > get to test kernel-de-jour, and this always has the latest userspace, so
 > > we don't notice problems until a kernel point release and the stable
 > > distro gets an update).
 > 
 > Ah, nice idea, I'll try to set up the same thing for Gentoo's kernels.
 > Hopefully the expanded coverage will help...

Cool, lets see which distro has the largest suicide-squad :-P

		Dave

