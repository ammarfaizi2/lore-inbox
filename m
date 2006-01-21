Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWAUJCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWAUJCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWAUJCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:02:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7646 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750890AbWAUJCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:02:06 -0500
Date: Sat, 21 Jan 2006 10:01:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
In-Reply-To: <1137810430.3241.97.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0601211000060.21704@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de>  <200601191947.20748.pzad@pobox.sk>
  <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr> <1137810430.3241.97.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have a card that works with the snd-cs46xx module.
>> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
>> other two must be sent to /dev/adsp. Is this intended? Would not it be 
>> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>
>Why can't you just use aoss?

Did not know it before.


Jan Engelhardt
-- 
