Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWBTO4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWBTO4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWBTO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:56:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50410 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030271AbWBTO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:56:45 -0500
Date: Mon, 20 Feb 2006 15:56:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Harald Arnesen <harald@skogtun.org>, Lee Revell <rlrevell@joe-job.com>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler?
Message-ID: <20060220145644.GE1673@atrey.karlin.mff.cuni.cz>
References: <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <8764nagm2b.fsf@basilikum.skogtun.org> <20060220144254.GC1673@atrey.karlin.mff.cuni.cz> <20060220144913.GA6391@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220144913.GA6391@kobayashi-maru.wspse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Mon, Feb 20, 2006 at 03:42:54PM +0100, Pavel Machek wrote:
> > Well, yep, it really depends on CPU/harddisk.
> 
> That is why a solution using LZF is needed, so either Suspend 2 or
> uswsusp.
> 
> > Can you try code from suspend.sf.net? It should be as fast as
> > suspend2.
> 
> I would like to have a look at it, but http://suspend.sourceforge.net/
> gives me an empty directory and http://sourceforge.net/suspend/ a "page
> not found".

Ahha, sorry, go to www.sf.net/projects/suspend/ , then check out code
from CVS, there's nice description how to do that there.
								Pavel
-- 
Thanks, Sharp!
