Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTKXJQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTKXJQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:16:03 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:27446 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263680AbTKXJQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:16:01 -0500
Date: Mon, 24 Nov 2003 04:15:38 -0500
From: Alan Cox <alan@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@redhat.com>, Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: modular IDE in 2.4.23
Message-ID: <20031124091538.GA18057@devserv.devel.redhat.com>
References: <200311232226.08882.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.44.0311232224510.1292-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311232224510.1292-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm, actually you are right.  Sorry :-).
> 
> So mind you or Alan write a patch for me, please? 

If I have time. I can't guarantee that.

If you do pull the hotplug out instead, remember to carefully reverse
the relevant PPC changes too or you'll break all the PPC spin up stuff

