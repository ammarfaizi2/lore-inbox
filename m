Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWBTUkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWBTUkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWBTUkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:40:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:23973 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161172AbWBTUka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:40:30 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@ucw.cz>, Mark Lord <lkml@rtr.ca>,
       Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <d120d5000602201215p61aa676bx21a85adfa7c76816@mail.gmail.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060220103329.GE21817@kobayashi-maru.wspse.de>
	 <1140434146.3429.17.camel@mindpipe> <200602202124.30560.nigel@suspend2.net>
	 <20060220132333.GB23277@atrey.karlin.mff.cuni.cz> <43F9D0DC.5080302@rtr.ca>
	 <20060220143041.GB1673@atrey.karlin.mff.cuni.cz>
	 <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
	 <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
	 <1140464704.6722.8.camel@mindpipe>
	 <d120d5000602201215p61aa676bx21a85adfa7c76816@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 15:40:27 -0500
Message-Id: <1140468027.6722.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 15:15 -0500, Dmitry Torokhov wrote:
> Well, if that is harmless I am not sure what you'd call harmful ;) 
> because right after this message the box hangs solid and I have to
> push and hold power button to power it off and start again.
> 

I don't think the watchdog does this.  Probably the machine would have
locked up anyway.  If you disable the watchdog does the machine keep
going?

Lee

