Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWHGIkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHGIkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWHGIkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:40:05 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:30975 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751161AbWHGIkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:40:03 -0400
Date: Mon, 7 Aug 2006 11:40:00 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Message-ID: <20060807084000.GA3802@rhun.haifa.ibm.com>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <1154930669.7642.12.camel@localhost.localdomain> <200608070817.42074.ak@muc.de> <20060807062705.GB4979@rhun.haifa.ibm.com> <Pine.LNX.4.61.0608070934030.12594@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608070934030.12594@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 09:34:43AM +0200, Jan Engelhardt wrote:
> 
> >baremetal.h seems appropriate.
> 
> <vanilla.h>, in hommage to "vanilla kernel".

I think most people use 'vanilla' to mean 'mainline', as in Linus's
kernel, so I find 'baremetal' (as opposed to 'virtualized') more
appropriate but... since this thread has all of the characteristics of
your favorite bike-shed, I'll bow out of it now :-)

Cheers,
Muli



