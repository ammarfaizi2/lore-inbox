Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVC3Fnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVC3Fnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVC3Fnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:43:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12488 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261435AbVC3FmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:42:10 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Chris Friesen <cfriesen@nortel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <3437534780e9f73588875e8964bac2ed@dalecki.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
	 <1112084311.5353.6.camel@gaston>
	 <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
	 <1112134385.5386.22.camel@mindpipe>  <4249E3F4.8070005@nortel.com>
	 <1112139564.31848.65.camel@gaston>
	 <3437534780e9f73588875e8964bac2ed@dalecki.de>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 00:42:09 -0500
Message-Id: <1112161330.5598.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 03:48 +0200, Marcin Dalecki wrote:
> On 2005-03-30, at 01:39, Benjamin Herrenschmidt wrote:
> > Look at the pile of junk that are most winmodem driver implementations,
> > nothing I want to see in the kernel ever. Those things should be in
> > userland.
> 
> You are joking? Linux IS NOT an RT OS.

Are you joking?  Any system that can capture audio, do a little DSP on
it and play it back without skipping can drive a Winmodem.  Are you
saying Linux can't possibly do that because it's not an RTOS?

I bet you could implement a Winmodem driver as a JACK client.

Lee



