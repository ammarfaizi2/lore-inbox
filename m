Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVACSj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVACSj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVACSgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:36:13 -0500
Received: from gprs215-122.eurotel.cz ([160.218.215.122]:1513 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261758AbVACSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:31:22 -0500
Date: Mon, 3 Jan 2005 19:28:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org
Subject: 2.6.10-mm1: oops during swsusp in ac97 support
Message-ID: <20050103182842.GA1420@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have via82xx soundcard, and since 2.6.10-mm1, I get an oops in
snd_ac97_resume. Does 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
