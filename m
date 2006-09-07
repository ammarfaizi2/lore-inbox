Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWIGVEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWIGVEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIGVEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:04:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6595 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932182AbWIGVEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:04:05 -0400
Date: Thu, 7 Sep 2006 23:03:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch 37/37] sky2: version 1.6.1
Message-ID: <20060907210346.GF29890@elf.ucw.cz>
References: <20060906224631.999046890@quad.kroah.org> <20060906225812.GL15922@kroah.com> <20060907192528.GG8793@ucw.cz> <20060907203426.GB556@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907203426.GB556@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > -stable review patch.  If anyone has any objections, please let us know.
> > > 
> > > ------------------
> > > From: Stephen Hemminger <shemminger@osdl.org>
> > > 
> > > Since this code incorporates some of the fixes from 2.6.18, change
> > > the version number.
> > > 
> > > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Not sure, one of 'stable' criteria is 'fixes bad bug'. What bug does
> > this fix?
> 
> The previous 5 patches changed this driver, so changing the version
> number of it is acceptable to me.

Well... I agree that version change is understandable, but it will be
also surprising for the users, and stable rules were quite strict with
"must fix obvious bug"...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
