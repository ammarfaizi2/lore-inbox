Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTJBQkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTJBQkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:40:02 -0400
Received: from thunk.org ([140.239.227.29]:27345 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263419AbTJBQkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:40:00 -0400
Date: Thu, 2 Oct 2003 12:39:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: John Bradford <john@grabjohn.com>, xen-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
Message-ID: <20031002163911.GD13652@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	John Bradford <john@grabjohn.com>, xen-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200310021515.h92FF1N3000239@81-2-122-30.bradfords.org.uk> <E1A55P2-00065x-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A55P2-00065x-00@wisbech.cl.cam.ac.uk>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 04:30:04PM +0100, Keir Fraser wrote:
> No --- Xen runs on x86 but exports a different 'x86-xeno' virtual
> architecture that OSes must be ported to (basically, privileged ops
> must go through Xen for validation).
> 
> x86 != x86-xeno, so Xen will not run on Xen.

And the amount of work to port the architecture-specific porions of
Xen to x86-xeno would be.....?   :-)

							- Ted
