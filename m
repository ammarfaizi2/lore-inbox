Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVBUQ3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVBUQ3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVBUQ3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:29:40 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:46035 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262026AbVBUQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:29:35 -0500
Date: Mon, 21 Feb 2005 11:29:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Doug McLain <nostar@comcast.net>
Cc: PALFFY Daniel <dpalffy-lists@rainstorm.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption
Message-ID: <20050221162923.GA29621@havoc.gtf.org>
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com> <Pine.LNX.4.58.0502211219250.23186@rainstorm.org> <4219A3AD.1000002@comcast.net> <421A0990.7070506@pobox.com> <4219C543.8030903@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219C543.8030903@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 11:25:55AM +0000, Doug McLain wrote:
> Jeff Garzik wrote:
> >Doug McLain wrote:
> >
> >>The sata_sil driver is without a doubt, totally hosed.  I, along with 
> >
> >
> >"without a doubt" being defined, of course, as "it works for a lot of 
> >people."
> >
> >    Jeff
> >
> >
> >
> >
> Thats like saying "turn up the radio" when your car makes a funny noise, 
> or "if a tree falls in the woods and nobody is there to hear it, does it 
> make a sound?"
> 
> It's tempting and comforting to pick the good ones as an example, and 
> some bugs are hard enough to find, let alone fix.  In the end though, if 
> one is broke, it's still broke, isn't it?

In this case, the bug _reports_ are hard to find.

Each case with sata_sil is either solved with a BIOS update, a
blacklist entry, or new cables.  Just read through bugzilla.kernel.org.

	Jeff



