Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267187AbUBSNwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUBSNwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:52:37 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:20187 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267187AbUBSNwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:52:08 -0500
Message-ID: <1077197950.4034bc7ec9730@imp1-q.free.fr>
Date: Thu, 19 Feb 2004 14:39:10 +0100
From: j.combes.ml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Strange problem with alsa, emu10k1 and ut2003 on 2.6.3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a strange problem with the sound on my PC [1] with the kernel
2.6.3 when I play to unreal tournement 2003. I use the same configuration
as the 2.6.1 which work quite well on my computer.

When I play to UT2003, sounds are not clean : there is some crackling.
Moreover, the music is played two or three time faster than normally. As
I haven't got this problem with 2.6.1, I imagine that it can be a problem
with the new alsa version.

I test to read some mp3 with xmms, it seem to work correctly.

any advices ?

[1] Athlon 2400+, VIA KT400, sblive, geforce fx with nvidia driver,
PREEMPT enabled.

Regards,
Julien


