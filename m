Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271011AbRHODRW>; Tue, 14 Aug 2001 23:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271010AbRHODRM>; Tue, 14 Aug 2001 23:17:12 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:53768
	"EHLO ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S271008AbRHODRA>; Tue, 14 Aug 2001 23:17:00 -0400
Date: Tue, 14 Aug 2001 12:29:55 -0400
From: Eric Buddington <eric@sparrow.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: VM (runaway kswapd) improvement 32Mb/120Mb 2.4.7-ac10 -> 2.4.8-ac4
Message-ID: <20010814122955.Q607@sparrow.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, my Omnibook 4100 (PII) with 32Mb RAM and 120Mb swap had some
trouble with frequent bursts of 98% system time and high kswapd CPU
usage under 2.4.7-ac10 while compiling the kernel and running festival
(memory-intensive speech synthesizer).

Currently, with 2.4.8-ac4, everything is just swell. Thanks to whoever
did the tweaking.

-Eric
