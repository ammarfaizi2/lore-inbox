Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbTHOQe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbTHOQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269400AbTHOQJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Input issues - key down with no key up
Date: Fri, 15 Aug 2003 15:05:00 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbjptkq.8k7.lunz@absolut.localnet>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815124318.GA15478@ucw.cz>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vojtech@suse.cz said:
> be doing) PS/2 genre of keyboards. For USB for example you don't get an
> interrupt and a scancode per keypress. You get the current keyboard
> state.

Then how am I getting infinitely repeating keys with a USB keyboard? I
recently switched to a kinesis ergo USB keyboard, and I had to disable
autorepeat in X because I had problems with keys occasionally repeating
infinitely until I hit something else to make it stop. I haven't tracked
down whether that's a hardware problem or in software.

Are you aware of that happening with USB keyboards?

Jason

