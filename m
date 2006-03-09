Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWCIXP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWCIXP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCIXP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:15:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:36834 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751888AbWCIXP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:15:26 -0500
X-Authenticated: #20450766
Date: Fri, 10 Mar 2006 00:15:24 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Adrian Bunk <bunk@stusta.de>
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
In-Reply-To: <1141944417.13319.84.camel@mindpipe>
Message-ID: <Pine.LNX.4.60.0603100011160.14584@poirot.grange>
References: <Pine.LNX.4.60.0603022032040.4969@poirot.grange> 
 <1141331113.3042.5.camel@mindpipe>  <Pine.LNX.4.60.0603022132160.4969@poirot.grange>
  <1141333305.3042.14.camel@mindpipe>  <Pine.LNX.4.60.0603022207160.3033@poirot.grange>
  <1141334604.3042.17.camel@mindpipe>  <Pine.LNX.4.60.0603022226130.3033@poirot.grange>
  <1141335418.3042.25.camel@mindpipe>  <Pine.LNX.4.60.0603030012070.3397@poirot.grange>
  <1141342018.3042.40.camel@mindpipe>  <Pine.LNX.4.60.0603030707270.2959@poirot.grange>
  <1141410043.3042.116.camel@mindpipe>  <Pine.LNX.4.60.0603041429340.3283@poirot.grange>
  <20060304154357.74f74cac@localhost>  <Pine.LNX.4.60.0603041823560.3601@poirot.grange>
  <1141495123.3042.181.camel@mindpipe>  <Pine.LNX.4.60.0603042046450.3135@poirot.grange>
  <1141509605.14714.11.camel@mindpipe>  <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
  <Pine.LNX.4.60.0603071851190.3662@poirot.grange>  <1141757284.767.56.camel@mindpipe>
  <Pine.LNX.4.60.0603071955350.3662@poirot.grange>  <1141758903.767.62.camel@mindpipe>
  <Pine.LNX.4.60.0603092336150.14584@poirot.grange> <1141944417.13319.84.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006, Lee Revell wrote:

> OK, please file a report in the ALSA bug tracker against this driver.

Yep, I will. I am afraid, I lied to you at one place - as I said that 
2.4.32 didn't work either. I tested 2.4.32, but used drivers from 
alsa-driver-1.0.3. I wasn't able to compile any recent version of 
alsa-library against 2.4.x native alsa drivers. I might try some older 
version of alsa-lib. I'll try to put as much information as possible in 
the bug-report.

Thanks
Guennadi
---
Guennadi Liakhovetski
