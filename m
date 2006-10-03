Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbWJCWSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbWJCWSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbWJCWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:18:20 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:13525 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1030605AbWJCWST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:18:19 -0400
Date: Tue, 3 Oct 2006 15:16:12 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003221612.GA1790@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 02:59:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 3 Oct 2006, John W. Linville wrote:
> >
> > I.E.  With "WE-21 aware" tools already in the wild, it isn't now clear
> > to me how WE can evolve any further than WE-20.
> 
> Well, if you get a WE-22 out soon enough, the situation will be one where 
> people who are fast at updating will have a fixed version quickly, and the 
> ones that aren't quick at updating will never have even seen the broken 
> case.

	Wrong.
	Slackware has just released with WE-21 aware tools. Users of
this version of Slackware will never see anything else than WE-21
aware tools. And if there is a distro and users which are
conservative, this is Slackware.
	Same deal for Mandriva 2007.
	Regards,

	Jean
