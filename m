Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTHQVlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271071AbTHQVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:41:21 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:56261 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S271055AbTHQVlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:41:20 -0400
Date: Mon, 18 Aug 2003 01:41:31 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030818014131.A29736@beton.cybernet.src>
References: <20030817233306.CC67A2D0074@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030817233306.CC67A2D0074@beton.cybernet.src>; from MAILER-DAEMON@beton.cybernet.src on Mon, Aug 18, 2003 at 01:33:06AM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Best uptime so far: a little more than 16 hours. Usually it locks up a lot 
> > earlier. When I do network transfers I can cause it to lock within a few 
> > minutes. Under "the other OS" it runs without any problems.
> 
> A friend had lots of problems with his NForce2 mobo until he ran memtest86
> and found that the memory was flaky.  His machine has been running linux
> very well since he replaced the memory.  (Heh, two days ago  ;-)
> 
> I wonder if the NForce2 is a bit fussier about the quality of the memory
> than other chipsets.

I ran memtest overnight and everything was 100% OK.

Cl<

