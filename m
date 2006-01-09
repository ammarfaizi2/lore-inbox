Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWAIQVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWAIQVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAIQVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:21:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44515 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964844AbWAIQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:21:18 -0500
Subject: Re: reiserfs mount time
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601091717400.26210@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
	 <1136763077.2997.4.camel@mindpipe>
	 <Pine.LNX.4.61.0601091717400.26210@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 11:21:15 -0500
Message-Id: <1136823676.9957.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 17:18 +0100, Jan Engelhardt wrote:
> >> 
> >> brought to attentino on an irc channel, reiser seems to have the largest 
> >> mount times for big partitions. I see this behavior on at least two 
> >> machines (160G, 250G) and one specially-crafted virtual machine
> >> (a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
> >> Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
> >> from http://linuxgazette.net/122/TWDT.html#piszcz
> >> So, any hint from the reiserfs developers how come reiserfs takes so long?
> >> Standard mkreiserfs options (none extra passed).
> >
> >reiser3 or reiser4?
> 
> For my case, reiser3.
> 
> (According to that pic link (from irc) also reiser4, but I'm inclined not 
> to believe that one.)

reiser3 is in maintenance mode so is unlikely to be fixed.  If you still
have the problem with reiser4 then they would probably like to hear
about it.

Lee

