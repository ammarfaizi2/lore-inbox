Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVCCTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVCCTin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCCTfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:35:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30656 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261389AbVCCSwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:52:08 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 13:52:06 -0500
Message-Id: <1109875926.2908.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
> The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
> purpose?  The thought of having to disable the headphone jack and reenable 
> it each time is trivial considering you can go with the fact that sound 
> did not require the sound system touched under <= 2.6.10.

You don't have to disable and re-enable it each time, if your system is
configured correctly then your mixer settings will be saved.

Lee

