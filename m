Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUGLS6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUGLS6C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGLS6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:58:02 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:31475 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261682AbUGLS55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:57:57 -0400
Subject: desktop and multimedia as an afterthought?
From: Florin Andrei <florin@sgi.com>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SGI
Message-Id: <1089658659.15341.56.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 11:57:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a kernel developer. I don't watch this mailing list too often.
I use Linux for pretty much everything, and especially for multimedia
(capture, process and edit video, music and sound processing, MIDI,
etc.).

I'm interested in anything that could make my system work better for my
multimedia apps. I used the Con Kolivas patches very early on, and i'm
also watching with interest the recent preemption patch posted by Ingo
Molnar.

I could be wrong, but it seems to me that at least a part of the kernel
development team has the desktop and multimedia issues very low on the
priority list.
The CK patches floated around as separate patches for a long time, even
though they brought significant improvements to the kernel w.r.t.
desktop and media.
Now the stock 2.6 kernel has a pretty bad problem with the latency.
Also, there seems to be a reluctance in accepting the autoregulated
swappiness patch, even though it markedly improves the overall behaviour
of the system as a desktop.

I am not familiar with the intricate technicalities of the Linux kernel,
so there might be purely technical reasons for keeping multimedia
improvements at an arm's length.
But on the other hand, there are many Linux users, myself included, that
repeatedly noticed how bad the stock Linux kernel is from a multimedia
perspective and how big are the improvements brought by these
seldom-if-at-all-included patches.

The CK patches have devouted "cult followers".
Projects such as PlanetCCRMA, which attempt to build a multimedia-ready
Linux distribution, are running kernels patched with the CK patches by
default.
On the Linux multimedia mailing lists and forums, one can often hear
advices in the vein of "use such-and-such patch if you want your system
to do any serious multimedia work, the vanilla kernel sucks."
And rightly so. If i reboot my computer into Windows and perform the
same multimedia tasks, there are fewer chances of it skipping frames or
otherwise behaving improperly for multimedia work than on Linux running
the vanilla kernel.

I mean, go read the forums. No one in the multimedia community uses the
vanilla kernel. They could be all wrong, sure, but there's lots of them.
:-)

There's a feature of the human brain to see patterns everywhere - i
think i see a pattern here. :-) It's like the desktop in general and
multimedia in particular matter a whole lot less than anything else on
Linux.

It seems like there's a split-brain situation within the Linux
community, with the core kernel developers sitting on one side of the
rift, and the multimedia people on the other side.

Now, i remember someone saying, a while ago, that the server stuff is
pretty much done, and the interesting things are going to happen on the
desktop. That sounds plausible, but if the kernel has poor support for
typical desktop scenarios, how are those big desktop improvements going
to take place?

I'm not saying that the whole thing happens on purpose. I'm just saying
that perhaps the latency and swappines issues and all might deserve a
bit more attention.

Thank you, and i'm looking forward to constructive criticism.

-- 
Florin Andrei

http://florin.myip.org/


