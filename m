Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVF1X6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVF1X6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVF1Xnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:43:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261530AbVF1XRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:17:40 -0400
Date: Tue, 28 Jun 2005 16:16:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, khali@linux-fr.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, tytso@mit.edu,
       zwane@arm.linux.org.uk, jmforbes@linuxtx.org, rdunlap@xenotime.net,
       torvalds@osdl.org, chuckw@quantumlinux.com, alan@lxorguk.ukuu.org.uk,
       andrew.vasquez@qlogic.com, James.Bottomley@SteelEye.com
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow board initialization.
Message-ID: <20050628231636.GK9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net> <20050627225349.GK9046@shell0.pdx.osdl.net> <20050628235148.4512d046.khali@linux-fr.org> <20050628152037.690c3840.akpm@osdl.org> <20050628223012.GG9046@shell0.pdx.osdl.net> <20050628160931.0e7d6b41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628160931.0e7d6b41.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Nope - I'm just making vague unsubstantiated accusations ;)

Heh ;-)

> <general handwaving> Given the number of bugs which are present in each
> release (as evidenced by the amount of stuff we're fixing), there's a hell
> of a lot of material which _could_ go into -stable.
> 
> I suspect some things are slipping through.  It's a big job though.
> 
> I didn't help much in 2.6.11.x and am paying more attention this time,
> mainly by being more vigilant looking at the commits list.

It would really help if patch author (or committer) thought to send it on,
distributing the load...
