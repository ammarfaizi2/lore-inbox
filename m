Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129315AbRBSF0Z>; Mon, 19 Feb 2001 00:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBSF0Q>; Mon, 19 Feb 2001 00:26:16 -0500
Received: from ohiper1-108.apex.net ([209.250.47.123]:24844 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129315AbRBSF0G>; Mon, 19 Feb 2001 00:26:06 -0500
Date: Sun, 18 Feb 2001 23:27:57 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: "i810_audio: DMA overrun on send" countless times in logs
Message-ID: <20010218232757.A2963@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:19pm  up 1 day,  2:48,  1 user,  load average: 2.24, 2.28, 2.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message pops up in my logs countless times, often accompanied by
temporarily freezes of the system, and pops in the sound.  It seems to
occur more often when under load, i.e. playing a DVD.  In fact, they
degrade the performance so badly as to make DVDs unwatchable.

I would chock this up to crappy hardware, accept that these errors don't
occur with the ALSA drivers, even under the same situations.  Not just
the absense of the messages, but the absense of the symptoms.

Thanks
-- 
-Steven
Never ask a geek why, just nod your head and slowly back away.
