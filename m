Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbTGET1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266447AbTGET0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:26:54 -0400
Received: from smtp.terra.es ([213.4.129.129]:53445 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S266439AbTGET0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:26:19 -0400
Date: Sat, 5 Jul 2003 21:40:06 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Daniel Phillips <phillips@arcor.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030705214006.37a52d15.diegocg@teleline.es>
In-Reply-To: <200307051728.12891.phillips@arcor.de>
References: <20030703023714.55d13934.akpm@osdl.org>
	<200307050216.27850.phillips@arcor.de>
	<200307051728.12891.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> to get us so far with this.  The situation re scheduling in 2.5 feels
> much as the vm situation did in 2.3, in other words, we're halfway down a
> long twisty road that ends with something that works, after having tried
> and failed at many flavors of tweaking and tuning.  Ultimately the
> problem will be solved by redesign, and probably not just limited to
> kernel code.

I never run 2.3, but 2.5 behaviour has been much better in the past. I used
to run make -j25 and mp3 didn't skip, X and all apps were still very
reponsive.

That was a lot of releases ago, before the so called linus' "interactivity"
patch. IMHO the behaviour in those releases was great; i think the
scheduler just needs a bit of tweaking from the Ingo's hand :)
