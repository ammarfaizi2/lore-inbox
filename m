Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVHTFRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVHTFRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 01:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVHTFRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 01:17:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7884 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750953AbVHTFRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 01:17:32 -0400
Subject: Re: [Alsa drivers] Creatives X-Fi chip
From: Lee Revell <rlrevell@joe-job.com>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <1124491956.25424.95.camel@mindpipe>
References: <4305AC77.3010907@cs.aau.dk>
	 <1124491956.25424.95.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 01:17:28 -0400
Message-Id: <1124515049.26949.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 18:52 -0400, Lee Revell wrote:
> If this is the long awaited emu10k3, then there's a good chance we can
> support it.  But we'll need at the very least a hardware sample from
> Creative. 

OK, it's the ca20k1 (!).  So it's likely to be as different from the
emu10k1 and emu10k1 as those were from the AWE32 or whatever came
before.

IOW there's no way we can write a driver for this without some docs from
Creative.  Unless they are planning on submitting their own driver of
course.

Lee 

