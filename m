Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTGHUfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbTGHUfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:35:10 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:35480 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265341AbTGHUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:35:06 -0400
Date: Tue, 8 Jul 2003 22:49:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: compactflash cards dying in < hour?
Message-ID: <20030708204931.GA602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had three diferent CF cards, from two different manufacturers
(Apacer and Transcend), and both died *really fast*.

Last one (transcend) died in less than 10 minutes: mke2fs, cat
/dev/urandom > foo; md5sum foo (few times); cat /dev/urandom > foo and
I could no longer do cat /dev/urandom because of disk errors.

I know CompactFlash cards are *crap*, but they should not be *so*
crappy...?! [I'm testing them from toshiba satellite 4030cdt via
Apacer PCMCIA-to-CF adapter and in sharp zaurus].

Are there "known good" 256MB compact flash cards?

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
