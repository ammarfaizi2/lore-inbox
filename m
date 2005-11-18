Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVKRXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVKRXjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVKRXjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:39:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4497 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751192AbVKRXjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:39:04 -0500
Date: Fri, 18 Nov 2005 23:22:07 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051118232206.GB2359@spitz.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117165437.GA10402@dspnet.fr.eu.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What unstable implementation? swsusp had very little regressions over past
> > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> 
> Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> suspend-to-disk or both?

Read the docs. swsusp is suspend-to-disk, of course.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

