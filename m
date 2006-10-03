Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWJCTA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWJCTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWJCTA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:00:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52970 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030469AbWJCTA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:00:28 -0400
Message-ID: <4522B311.7070905@garzik.org>
Date: Tue, 03 Oct 2006 14:59:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com>
In-Reply-To: <20061003183849.GA17635@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Now it's too late, those changes have propagated to userspace
> tools, and are now shipping in some actual release of some distro. So,
> what are we going to say to Mandriva 2007 and FC6 users, to revert
> back to an *older* version of the tools ?
> 	Because userspace has already been updated, we have only two
> options, merge it now, or in 2.6.20.

If the choice is between the ABI used by a bunch of distros in 
production, and the ABI used by two re-release distros, I think the 
choice is obvious...

	Jeff


