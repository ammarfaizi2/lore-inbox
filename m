Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263572AbTCUJy3>; Fri, 21 Mar 2003 04:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbTCUJy3>; Fri, 21 Mar 2003 04:54:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263572AbTCUJy2>;
	Fri, 21 Mar 2003 04:54:28 -0500
Date: Thu, 20 Mar 2003 21:51:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Time problems in 2.5.65
Message-ID: <20030320205144.GB739@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Bad things happen on 2.5.65 (and it was there in 2.5.64, too). Time in
emacs jumps ~hour forward and then stays there. No ntpd complains in
syslog and time of all syslog messages is monotically
increasing. Anyone seen that before? Athlon notebook.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
