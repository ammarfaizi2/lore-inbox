Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBMRmv>; Tue, 13 Feb 2001 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRBMRml>; Tue, 13 Feb 2001 12:42:41 -0500
Received: from 041imtd176.chartermi.net ([24.247.41.176]:58772 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S129032AbRBMRm3>; Tue, 13 Feb 2001 12:42:29 -0500
Date: Tue, 13 Feb 2001 12:42:26 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org
Subject: LDT allocated for cloned task!
Message-ID: <20010213124226.A15600@stormix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LDT allocated for cloned task!

I'm seeing this message come up fairly often while running vanilla
2.4.2-pre3 on my dual Celeron system.  I don't think I saw it before
while running 2.4.1, but I may have just missed it.

My system has been up around two days and has 11 of these messages in the
ring buffer.

Actually, I just remembered that I'm using the mga DRI driver module
from the DRI CVS tree rather than the built-in module, so that's not part
of the official kernel...maybe that is causing the messages.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
