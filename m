Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbUJXKjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUJXKjX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUJXKjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:39:23 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20753 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261433AbUJXKep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:34:45 -0400
Date: Sun, 24 Oct 2004 12:40:38 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Jan Knutar <jk-lkml@sci.fi>, Stephen Wille Padnos <spadnos@sover.net>,
       Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041024104038.GA12665@hh.idb.hist.no>
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41793C94.3050909@techsource.com>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:00:04PM -0400, Timothy Miller wrote:
> 
> 
> 
> For this graphics design, and I'm getting into premature implementation 
> details, but I'm a geek, so I can't help myself... I think having some 
> sort of primitive microcontroller at the front end of the design is 
> necessary.  Two major things it would do would be to control the DMA bus 
> mastering, and translate commands (both DMA and PIO) into the parameters 
> required by the rendering engine.
> 

Perhaps a cheap general purpose cpu (last year's duron or celeron)
could be used for this in order to save cost?  You could sell the
cheapest version of the card with an empty socket, because so many
people have such a processor lying around after the last upgrade.

Helge Hafting
