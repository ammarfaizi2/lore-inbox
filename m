Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVBYVzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVBYVzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVBYVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:55:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:430 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262625AbVBYVuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:50:19 -0500
Subject: Re: 2.6.11-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <421F9CE3.7010500@tmr.com>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <421F9CE3.7010500@tmr.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 16:50:15 -0500
Message-Id: <1109368215.13193.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 16:47 -0500, Bill Davidsen wrote:
> - sound: hasn't worked since FC1...
> 

The ALSA lists have been deluged with reports like "sound worked in FC1,
upgraded to FC3, no sound".   AFAICT it's just sloppiness on the part of
the Fedora userspace tools.  For example, last I heard
system-config-soundcard tries to load the emu10k1 module for cards that
need the (completely different) emu10k1x driver.

Lee

