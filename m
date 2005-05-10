Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVEJQL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVEJQL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEJQL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:11:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40068 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261687AbVEJQLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:11:54 -0400
Subject: Re: Restoring the link to snapshots on kernel.org
From: Lee Revell <rlrevell@joe-job.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, webmaster@kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <4280DB48.70908@zytor.com>
References: <200505100110.16920.blaisorblade@yahoo.it>
	 <200505101217.56252.blaisorblade@yahoo.it>
	 <20050510034212.0d1e0799.akpm@osdl.org>
	 <200505101243.38102.blaisorblade@yahoo.it>  <4280DB48.70908@zytor.com>
Content-Type: text/plain
Date: Tue, 10 May 2005 12:11:50 -0400
Message-Id: <1115741511.12402.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 09:03 -0700, H. Peter Anvin wrote:
> Blaisorblade wrote:
> > 
> >>Nope.  They started again five days ago.
> > 
> > Would anybody restore the link from the main www.kernel.org/ page, then? I 
> > only see there (and in the finger banner) the 2.4 snapshots, not the 2.6 
> > ones.
> > 
> > I just found
> > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/, but only by knowing 
> > there were the snapshots somewhere.
> 
> It's because there is no snapshots against -rc4, simply because Linus is 
> on vacation and thus there hasn't been any changes since -rc4.
> 

How about cleaning up the v2.6/testing directory?

 [   ]  ChangeLog-2.6.9-rc4                10-Oct-2004 22:15   115k
 [   ]  LATEST-IS-2.6.11-rc5               24-Feb-2005 10:58     0k
 [   ]  LATEST-IS-2.6.12-rc1               17-Mar-2005 20:41     0k
 [   ]  LATEST-IS-2.6.12-rc2               04-Apr-2005 11:41     0k
 [   ]  LATEST-IS-2.6.12-rc3               20-Apr-2005 19:21     0k
 [   ]  LATEST-IS-2.6.12-rc4               07-May-2005 00:41     0k
 [DIR]  cset/                              04-Apr-2005 12:16      -

Lee

