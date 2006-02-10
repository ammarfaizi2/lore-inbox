Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWBJXuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWBJXuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBJXuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:50:44 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:53265 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1750825AbWBJXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:50:43 -0500
To: Marc Koschewski <marc@osknowledge.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
	<20060210175848.GA5533@stiffy.osknowledge.org>
	<43ECE734.5010907@cfl.rr.com>
	<20060210210006.GA5585@stiffy.osknowledge.org>
	<1139613834.14383.5.camel@localhost.localdomain>
	<20060210234121.GC5713@stiffy.osknowledge.org>
From: Doug McNaught <doug@mcnaught.org>
Date: Fri, 10 Feb 2006 18:50:37 -0500
In-Reply-To: <20060210234121.GC5713@stiffy.osknowledge.org> (Marc
 Koschewski's message of "Sat, 11 Feb 2006 00:41:21 +0100")
Message-ID: <87accyu62a.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski <marc@osknowledge.org> writes:

> I'm also curious when DELL will release their first mobile with SCSI
> onboard instead of IDE. The chips are the same size...

That's very unlikely to ever happen, but I do hear that laptops are
starting to use SATA rather than IDE, at least for the hard disk.
That would help with the bus-locking problem...

-Doug
