Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUBWUvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUBWUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:51:52 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:49327 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261956AbUBWUvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:51:49 -0500
Date: Mon, 23 Feb 2004 15:32:19 -0500
From: Ben Collins <bcollins@debian.org>
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: only ieee1394 from 2.4.20 works for me
Message-ID: <20040223203219.GJ1463@phunnypharm.org>
References: <4038BDC3.9030304@kuix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038BDC3.9030304@kuix.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lack of response is probably why you haven't gotten any help. I
can't magically fix the issues you are seeing.

I did however take the time today to load up 2.4.25 on my AMD/nForce
box, and was able to load sbp2 and read/write from a drive without any
problems (even did an fsck afterwards to make sure) and also captured
some video frames with video1394 using coriander.

I didn't see any problems, but then again with such a vague complaint
it's sort of hard to attempt to reproduce anything.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
