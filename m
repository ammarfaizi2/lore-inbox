Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUKSDMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUKSDMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 22:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbUKSDMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 22:12:03 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34280 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261247AbUKSDMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 22:12:00 -0500
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20041118184524.GA19606@havoc.gtf.org>
References: <20041117163016.A5351@tuxdriver.com>
	 <20041117145644.005e54ff.akpm@osdl.org> <419CE98B.2090304@pobox.com>
	 <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr>
	 <419CEC33.3010208@pobox.com>
	 <Pine.LNX.4.53.0411181940580.8260@yvahk01.tjqt.qr>
	 <20041118184524.GA19606@havoc.gtf.org>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 20:23:01 -0500
Message-Id: <1100827381.11044.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 13:45 -0500, Jeff Garzik wrote:
> On Thu, Nov 18, 2004 at 07:41:44PM +0100, Jan Engelhardt wrote:
> > >Until it's gone, the current users would prefer not-broken to broken.
> > 
> > Well, leave it broken and reason it with "come over to ALSA".
> 
> i810 audio still locks up in ALSA ATM...
> 

Fixed in ALSA CVS on Tuesday.  This fix needs to go in 2.6.10 IMO.

Lee

