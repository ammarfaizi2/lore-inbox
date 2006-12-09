Return-Path: <linux-kernel-owner+w=401wt.eu-S967835AbWLIMPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967835AbWLIMPY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936954AbWLIMPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:15:24 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47568 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936931AbWLIMPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:15:23 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 07:11:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jeff Garzik <jeff@garzik.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
In-Reply-To: <457A9F3B.6020009@garzik.org>
Message-ID: <Pine.LNX.4.64.0612090706500.13654@localhost.localdomain>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
 <457A9F3B.6020009@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Jeff Garzik wrote:

> The protocol is simply to do best to give credit where credit is
> due. If your patch is taken directly, most likely it is a mistake if
> attribution was dropped.  If your patch was modified, often that
> patch will get checked in under the name of the person who last
> touched the change before commit -- and it is their responsibility
> to make sure and note that the change originally came from you.

and just to finish off this still-twitching horse, i'm not that
concerned if someone else gets the attribution.  that patch was so
trivial, it's not like i'm going to parade it around as my
contribution to the kernel.  (and, as i said, it's entirely possible
that this was just one of those wild coincidences.)

i'm far more interested in at least knowing what happens to patches
once they enter the system, so i can plan on what kind of cleanup i
can work on next.

rday
