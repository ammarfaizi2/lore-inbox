Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVIXJ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVIXJ5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 05:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVIXJ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 05:57:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31934 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751457AbVIXJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 05:57:51 -0400
Date: Sat, 24 Sep 2005 11:55:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Userland for 2.6 sharp zaurus sl-5500
Message-ID: <20050924095541.GD8946@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there someone out there that can easily generate userland for 2.6-based
sl-5500? I use bootstrap environment from oz, but it lacks bluetooth support,
nags me (waiting minute, flash correct kernel) and I'd like to run Opie it the end
(but probably default to shell; I'm too far away from that).

On a related note: is it possible to change just keernel (not initrd)?
I could flash initrd separately, but when I tried flashing just zimage,
it crashed on boot.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

