Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVCVEli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVCVEli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCVEdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:33:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7908 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262469AbVCVEaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:30:11 -0500
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       apatard@mandrakesoft.com, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20050321202303.58300ec6.akpm@osdl.org>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	 <20050321202022.B16069@flint.arm.linux.org.uk>
	 <20050321124159.0fbf1bef.akpm@osdl.org> <1111463491.3058.15.camel@mindpipe>
	 <20050321201040.2a241f15.akpm@osdl.org> <1111465002.3058.26.camel@mindpipe>
	 <20050321202303.58300ec6.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 23:30:09 -0500
Message-Id: <1111465809.3058.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 20:23 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> > I'm not aware of a mechanism for getting critical fixes like this in
> > ASAP.  The last few have been shepherded through manually by various
> > people.  Looks like we need a better system.
> > 
> 
> It's not a trivial problem.
> 

The linux-stable process seems to be working quite well so far.

Lee

