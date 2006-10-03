Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWJCSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWJCSk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWJCSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:40:57 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:15031 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S964852AbWJCSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:40:56 -0400
Date: Tue, 3 Oct 2006 19:31:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "John W. Linville" <linville@tuxdriver.com>
cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jeff@garzik.org,
       johannes@sipsolutions.net, jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061003180543.GD23912@tuxdriver.com>
Message-ID: <Pine.LNX.4.64.0610031923520.3328@blonde.wat.veritas.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
 <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
 <20061003180543.GD23912@tuxdriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Oct 2006 18:31:00.0218 (UTC) FILETIME=[13188DA0:01C6E71A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006, John W. Linville wrote:
> 
> Today's news seems to indicate that at least the major distros are
> already shipping the updated tools, or on the verge of shipping them.
> The window of breakage for most users looks like it will be fairly
> small, no matter what action taken.
> 
> The more we can clean-up the WE API, the easier it will be to implement
> the cfg80211 WE compatibility layer intended for wireless-dev.
> I think WE-21 makes things better in that respect.

Please correct me if I'm wrong: isn't it the case that a few of the
distros are now coming out with wireless_tools.28 supporting WE-20,
but current 2.6.18-git wireless drivers are WE-21, supported only
by wireless_tools.29.pre10?

Hugh
