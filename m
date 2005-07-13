Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVGMXLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVGMXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:32:26 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43188 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261934AbVGMRbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:31:34 -0400
Subject: Re: Linux v2.6.13-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:31:33 -0400
Message-Id: <1121275893.4435.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 22:05 -0700, Linus Torvalds wrote:
> I think the shortlog speaks for itself.

HZ still defaults to 250.  As was explained in another thread, this will
break apps like MIDI sequencers and won't really save much battery
power.

The default should remain 1000 until these issues are resolved.

Or am I wasting my time with this?

Lee

