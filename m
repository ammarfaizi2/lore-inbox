Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUJPUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUJPUhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUJPUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:37:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4510 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268851AbUJPUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:37:52 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: Lee Revell <rlrevell@joe-job.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
In-Reply-To: <200410162230.14363.dominik.karall@gmx.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <200410161621.34657.dominik.karall@gmx.net>
	 <20041016152427.GA16334@elte.hu>
	 <200410162230.14363.dominik.karall@gmx.net>
Content-Type: text/plain
Message-Id: <1097958703.2148.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 16:31:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 16:30, Dominik Karall wrote:
> sorry, i tried to reproduce this bug, but can't. i even don't know _when_ this 
> bug occurred, as i just wanted to take a look in the dmesg output after 
> loading sg module. but it does not depend on sg, as i unloaded it and tried 
> again to load.
> 

The trace looks like mplayer reading from a FAT filesystem.  Can you
reproduce the problem if you do whatever you were doing with mplayer 
again?

Lee

