Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWC0Jh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWC0Jh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 04:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC0Jh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 04:37:56 -0500
Received: from [213.20.50.130] ([213.20.50.130]:23847 "EHLO [213.20.50.130]")
	by vger.kernel.org with ESMTP id S1750724AbWC0Jhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 04:37:55 -0500
Date: Mon, 27 Mar 2006 11:38:29 +0200
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [GIT] overall system responsiveness / ALSA partly broken
Message-ID: <20060327093828.GA17512@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-marc-g5d5d7727
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

since the recent big checkout on Friday today was the first day the machine has
some heavy load (gcc, beep-media-player, 2 Mozilla instances wiht many tabs open,
...) and the system performs very bad. './configure' seems to take forever, the
average system load is about 10.2 all the time. But I do the same tasks as I do
every day. Moreover, ALSA doesn't play tracks from beep-media-player
continuouosly. I, however, don't know if it's related to the high system load or
if ALSA is broken. The problem is not reproducible. But sound keeps disturbed
from time to time (no sound, not a noise or something - just like a pause
button). The logs state nothing... 

If you need any more info, please ask.

Marc
