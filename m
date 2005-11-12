Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVKLDSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVKLDSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVKLDSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:18:50 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35230 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751109AbVKLDSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:18:49 -0500
Subject: Re: ALSA in 2.6.14: RTC timer breaks MIDI
From: Lee Revell <rlrevell@joe-job.com>
To: Marek Szuba <cyberman@if.pw.edu.pl>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0511120405470.27232@gyrvynk.vs.cj.rqh.cy>
References: <Pine.LNX.4.62.0511101735350.30579@gyrvynk.vs.cj.rqh.cy>
	 <s5hpsp7z39n.wl%tiwai@suse.de>
	 <Pine.LNX.4.62.0511120405470.27232@gyrvynk.vs.cj.rqh.cy>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 22:17:03 -0500
Message-Id: <1131765423.11279.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 04:07 +0100, Marek Szuba wrote:
> On Fri, 11 Nov 2005, Takashi Iwai wrote:
> 
> > A known problem.  Try the patch below.
> Works like a charm now, thanks.
> 

tiwai, can you forward the patch to stable@kernel.org?  This really
needs to make it into 2.6.14.3.

Lee

