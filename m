Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUGFB4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUGFB4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 21:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGFB4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 21:56:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26548 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262476AbUGFB4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 21:56:40 -0400
Date: Tue, 6 Jul 2004 03:56:20 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Message-ID: <20040706015620.GA12659@apps.cwi.nl>
References: <200407052352.51135.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.21.0407060020110.29315-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407060020110.29315-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 02:17:47AM +0200, Szakacsits Szabolcs wrote:
...

We agree about most of the facts, and I am too lazy to quarrel anyway.
Such a waste of time. But we draw different conclusions.

We discover that the present combination of 2.6 and parted is
unfortunate. Because of bugs in parted. OK - so lets fix them.
There is nothing especially difficult there.

You prefer a larger change to the kernel above a smaller change
to parted, where the change to parted fixes parted, and the change
to the kernel makes the kernel buggier. I do not.

You say that other utilities are affected. Maybe, yes.
So let us look at them. In the time spent writing all these
letters we probably could have fixed a few.

Andries
