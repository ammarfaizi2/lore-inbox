Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUJJUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUJJUIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUJJUIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:08:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23743 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268463AbUJJUIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:08:18 -0400
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <roland@topspin.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <52k6tzlhqt.fsf@topspin.com>
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
	 <41673772.9010402@pobox.com> <52zn2wlh8h.fsf@topspin.com>
	 <416767BA.1020204@pobox.com>  <52k6tzlhqt.fsf@topspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097435131.29422.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 10 Oct 2004 20:05:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-09 at 22:11, Roland Dreier wrote:
> I guess my point was not that the bluetooth stack is somehow
> questionable, but rather that the IP policies of a standards bodies
> are really not a good reason to keep code out of the kernel.  If
> someone can name one patent that the IB driver stack looks like it
> might possibly run into, then we would have to take that very
> seriously.  However, no one has done this here -- all we have is FUD
> or guilt by association or whatever you want to call it.

Its called "caution". It's why nobody does innovation in the USA any
more, its too dangerous to innovate. Far better to make it available as
before with a blue led and a beeper.

> The mere fact that the IBTA bylaws only require members license their
> patents under RAND terms shouldn't be an issue.  If nothing else, the
> fact that there are hugely more non-IBTA member companies than member
> companies who might have patents makes the IBTA bylaws almost a moot
> point.

The big question seems to be about the standard itself. Are the items at
issue hardware or software ? We already deal with a lot of devices that
have hardware related patent pools and those by themselves don't seem to
cause problems.

In the mean time I guess the guys down in Bristol[1] will be feeling
happier and happier at the Infiniband self destruct sequence.

Alan
[1] Quadrics


