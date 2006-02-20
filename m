Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWBTPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWBTPBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWBTPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:01:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20971 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030271AbWBTPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:01:35 -0500
Date: Mon, 20 Feb 2006 16:01:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220150135.GF1673@atrey.karlin.mff.cuni.cz>
References: <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <20060220135145.GA5534@kobayashi-maru.wspse.de> <20060220140719.GA31319@atrey.karlin.mff.cuni.cz> <20060220144244.GA6092@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220144244.GA6092@kobayashi-maru.wspse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > But then again, this was about work/not work, and there are still
> > > problems, so there is still efford needed. In this situation it is
> > > not good to just start over, but take the things that are already
> > > there and work with it.
> > 
> > I seen Nigel's recent patch. Yes, it is easier to just start over.
> > (8000 unneccessary lines... that's 3 times size of swsusp with uswsusp
> > included!)
> 
> Correct me if I am wrong, but I see your comments are about Suspend 2.2,
> while a lot of this was already be fixed in 2.2.0.1.
> 
> And Nigel has taken your points and preparing a new patch. So let see
> when it is ready.

Well... I trust that all the typos and =0 and // comments are going to
be fixed, but I somehow doubt he'll switch to mainline code and drop
his bitmaps or drop plugin architecture. If 2.2.0.2 is 8000 lines
smaller... I'd be pleasently surprised.
								Pavel
-- 
Thanks, Sharp!
