Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270435AbTGXDst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 23:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTGXDst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 23:48:49 -0400
Received: from mail.skjellin.no ([80.239.42.67]:10671 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S270435AbTGXDss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 23:48:48 -0400
Subject: Re: Feature proposal (scheduling related)
From: Andre Tomt <andre@tomt.net>
To: Valdis.Kletnieks@vt.edu
Cc: jimis@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
References: <3F1E6A25.5030308@gmx.net>
	 <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1059019460.2507.440.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 06:04:20 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ons, 2003-07-23 at 16:17, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 23 Jul 2003 13:57:41 +0300, jimis@gmx.net  said:
> > 1)I 'm connected to the internet via dial-up, therefore I only have 40 kbits of 
> > bandwidth available. What I want to do is listen to icecast radio via xmms (at
> > 22 kbits), download the kernel sources with wget, and browse the web at the same
> > time. Currently I think that this is *impossible* (correct me if I'm wrong) as
> > the radio will be full of pauses and the browsing experience painfully slow.
> 
> Basically, you're stuck.  The biggest part of the problem is that although you
> can certainly control the outbound packets, you have no real control over when
> inbound packets arrive at the other end of your dial-up.

Take a look at http://trash.net/~kaber/imq/
Does wonders here, both local and forwarded traffic.

-- 
Cheers,
André Tomt
andre@tomt.net

