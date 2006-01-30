Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWA3RJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWA3RJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWA3RJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:09:11 -0500
Received: from mail.gmx.net ([213.165.64.21]:46754 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964796AbWA3RJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:09:09 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 18:09:04 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060130170904.GH19173@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	bzolnier@gmail.com, acahalan@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <43DE2FF4.nail16ZCI3FMV@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE2FF4.nail16ZCI3FMV@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > 2) libscg or cdrecord aborts ATA: scans as soon as one device probe
> >    returns EPERM, which lets devices that resmgr made accessible
> >    disappear from the list.
> 
> looks like your memory does not last long enough......
> 
> We did already discuss this before. If you call cdrecord with
> apropriatr privileges, it works.

Well, if you're freezing the bugs, I don't see how there could be
progress towards a non-root cdrecord on Linux.

-- 
Matthias Andree
