Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTF0RHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 13:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTF0RHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 13:07:32 -0400
Received: from a213-22-72-104.netcabo.pt ([213.22.72.104]:32013 "EHLO
	utopia.ddts.net") by vger.kernel.org with ESMTP id S264499AbTF0RHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 13:07:31 -0400
Date: Fri, 27 Jun 2003 18:21:30 +0100
From: Paladin <paladin@utopia.ddts.net>
To: linux-kernel@vger.kernel.org
Subject: AC97 and i810 problem
Message-Id: <20030627182130.07c087a8.paladin@utopia.ddts.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently installed the 2.4.21 kernel. But with this version I
don't have sound. That is, sound coming from the CD is played, but
all other isn't.
I don't know how I can help you discover the problem, so I'm asking
some assistance to better report the problem.
For now I'll show you what is returned when I install the modules:

i810_audio: Audio Controller supports 2 channels.
i810_audio: Defaulting to base 2 channel mode.   
i810_audio: Resetting connection 0
ac97_codec: AC97  codec, id: CMI65 (CMedia)
AC97 codec does not have proper volume support.  
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2

The 5th line didn't appear before....

Thanks,

---
Paladin
