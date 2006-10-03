Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWJCTvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWJCTvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJCTvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:51:02 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:26876 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1750895AbWJCTvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:51:00 -0400
Date: Tue, 3 Oct 2006 12:48:11 -0700
To: Jeff Garzik <jeff@garzik.org>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003194811.GA17855@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522B311.7070905@garzik.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 02:59:29PM -0400, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> >	Now it's too late, those changes have propagated to userspace
> >tools, and are now shipping in some actual release of some distro. So,
> >what are we going to say to Mandriva 2007 and FC6 users, to revert
> >back to an *older* version of the tools ?
> >	Because userspace has already been updated, we have only two
> >options, merge it now, or in 2.6.20.
> 
> If the choice is between the ABI used by a bunch of distros in 
> production, and the ABI used by two re-release distros, I think the 
> choice is obvious...
> 
> 	Jeff

	Which means 2.6.20. Case closed.

	Jean
