Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWAaS6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWAaS6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWAaS6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:58:07 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:65476 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751348AbWAaS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:58:06 -0500
Date: Tue, 31 Jan 2006 13:58:04 -0500
To: Sander <sander@humilis.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131185804.GM18970@csclub.uwaterloo.ca>
References: <20060131115343.GA2580@favonius> <20060131163928.GE18972@csclub.uwaterloo.ca> <20060131171723.GA6178@favonius> <20060131183013.GH18970@csclub.uwaterloo.ca> <20060131183929.GB6178@favonius> <20060131184428.GJ18970@csclub.uwaterloo.ca> <20060131185007.GD6178@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131185007.GD6178@favonius>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 07:50:07PM +0100, Sander wrote:
> Actually, I need 24 ports :-)  But 3x SX8 sets me back 540 dollars
> according to pricewatch, which is less than half.

I know with older promise controllers, it wasn't possible to run more
than 2 in one system as far as I remember due to some dma issues.  Not
sure if that applies to the SX8.

If it turns out the SX8 has issues (like the one pointed out earlier
about number of commands to the card at once) or that it can't have 3
cards in one system at once, then what?  Are you then out $540 + the
cost of a better controller?  Certainly worth finding out before
spending the money.

> Fakeraid controllers are less expensive, and would do too of course :-)

Of course those aren't hardware, and are only meant for small toy raids
for windows users.  The rest of use treat them as ide/sata controllers
only.  I haven't seen one of those with more than 4 ports either.  If
the SX8 is one, then I must admit I haven't looked at it before.  I try
to avoid hardware from promise whenever possible.

Len Sorensen
