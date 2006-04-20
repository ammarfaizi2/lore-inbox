Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWDTWWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWDTWWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWDTWWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:22:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34195 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932085AbWDTWWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:22:04 -0400
Subject: Re: rtc: lost some interrupts at 256Hz
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Michael Monnerie <michael.monnerie@it-management.at>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
References: <200604202237.34134@zmi.at> <1145566983.5412.31.camel@mindpipe>
	 <Pine.LNX.4.61.0604210012530.28841@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 18:22:00 -0400
Message-Id: <1145571721.5412.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 00:18 +0200, Jan Engelhardt wrote:
> Does not really matter what userspace app is running. If it's mplayer
> the message is "rtc: lost some interrupts at 1024Hz.", and if it's
> VMware it's whatever the Guest OS requires, mostly 2000 or 200 Hz. 

I asked about the app because I was wondering whether he had a server or
a desktop.

Lee

