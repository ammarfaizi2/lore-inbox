Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVL0R1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVL0R1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVL0R1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:27:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17380 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751126AbVL0R1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:27:44 -0500
Date: Tue, 27 Dec 2005 18:27:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 0/3] swsusp: swap handling improvements
Message-ID: <20051227172725.GG1822@elf.ucw.cz>
References: <200512271747.43374.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200512271747.43374.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 27-12-05 17:47:42, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of patches improves the handling of swap partitions
> by swsusp and changes the way it writes the image to swap.  As a result,
> the swap-handling part of swsusp is simplified quite a bit.
> 
> The patches in this series are also necessary for implementing the swsusp's
> userland interface (coming soon).
> 
> The third patch has been acked by Pavel, but of course it depends on the
> previous two.  Still, I posted them for comments some time ago and there
> have not been any, so I assume there are no objections. ;-)

Just for the record, all the patches look good to me.
								Pavel
-- 
Thanks, Sharp!
