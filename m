Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266433AbTGETlV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266439AbTGETlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:41:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47241 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266433AbTGETlU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:41:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jul 2003 12:48:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030705214006.37a52d15.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.55.0307051246420.4599@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307050216.27850.phillips@arcor.de>
 <200307051728.12891.phillips@arcor.de> <20030705214006.37a52d15.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Diego Calleja [ISO-8859-15] García wrote:

>
> > to get us so far with this.  The situation re scheduling in 2.5 feels
> > much as the vm situation did in 2.3, in other words, we're halfway down a
> > long twisty road that ends with something that works, after having tried
> > and failed at many flavors of tweaking and tuning.  Ultimately the
> > problem will be solved by redesign, and probably not just limited to
> > kernel code.
>
> I never run 2.3, but 2.5 behaviour has been much better in the past. I used
> to run make -j25 and mp3 didn't skip, X and all apps were still very
> reponsive.

The first releases we shoot out were very good indeed. Now I believe
something got lost in the "evolution". Let's wait Ingo to come back
from Mars :)


- Davide

