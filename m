Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVDOB07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDOB07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDOB07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:26:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44942 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261708AbVDOB06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:26:58 -0400
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
From: Lee Revell <rlrevell@joe-job.com>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200504142119.04527.pmcfarland@downeast.net>
References: <200503201557.58055.pmcfarland@downeast.net>
	 <200503302359.39200.pmcfarland@downeast.net>
	 <200504070717.34113.pmcfarland@downeast.net>
	 <200504142119.04527.pmcfarland@downeast.net>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 21:26:56 -0400
Message-Id: <1113528416.19830.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 21:18 -0400, Patrick McFarland wrote:
> On Thursday 07 April 2005 07:17 am, Patrick McFarland wrote:
> > Nope, 2.6.7 is also fubar. Now to 2.6.6.
> 
> I haven't tested 2.6.6 yet, but 2.6.12-rc2-mm3 is broken too.
> 

There's no point in testing newer kernels if you have yet to find an old
2.6 kernel where it works.

Do you have any evidence that it ever worked with ALSA?  I suspect it's
always been broken, and that 2.6.8 or 2.6.9 system you referred to was
using the OSS driver.

Lee

