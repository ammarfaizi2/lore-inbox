Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTLRMY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 07:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbTLRMY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 07:24:59 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:56759 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S265113AbTLRMY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 07:24:58 -0500
Subject: Re: Wonderful World of Linux 2.6 - Final
From: Joe Pranevich <jpranevich@kniggit.net>
To: Ingo Molnar <mingo@redhat.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312180314330.17551@devserv.devel.redhat.com>
References: <3FE13D07.6080204@cyberone.com.au> <3FE1532A.2010109@pobox.com>
	 <Pine.LNX.4.58.0312180314330.17551@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1071750087.2820.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 07:21:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-18 at 03:16, Ingo Molnar wrote:
> On Thu, 18 Dec 2003, Jeff Garzik wrote:
> 
> > Are you sure?  I could have sworn Ingo made the scheduler magically
> > HT-friendly...
> 
> nope, it's not in 2.6 yet. This area is still under development, with
> various approaches being considered.

Aaah.... Drat. I could have sworn that it was in and noone caught the
error before.

Oh well. Guess in this case I was over-optimistic.

Until I have the chance to fix it, just imagine that the WWOL document
you are reading is not the 'real' document, but rather a fluke of
quantum science. By some amazing process that can only be properly
performed by semi-sane science professionals in non-laboratory
environments, this copy of WWOL has somehow transcended the dimensional
barrier. It is, in effect, from a parallel universe. In *that* universe,
Ingo completed the necessary changes and merged them into 2.6 quite some
time ago. 

The butterfly effect being what it is, I'm sure there are other changes
in that universe. For example, flamingos may be blue or green. As the
color of Caribbean birds rarely influence kernel development, we should
be otherwise generally safe.

Joe


