Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVBHM0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVBHM0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVBHM0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:26:18 -0500
Received: from smtp-out2.email.it ([80.247.70.7]:8141 "EHLO smtp-out2.email.it")
	by vger.kernel.org with ESMTP id S261522AbVBHM0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:26:12 -0500
Subject: [BUG Report] Hacks in IDE (perhaps) section => 2.6.8 make REALLYbad audio-cd's
From: Marco <feedback@email.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 08 Feb 2005 13:26:24 +0100
Message-Id: <1107865584.919.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.4 
Content-Transfer-Encoding: 7bit
X-Copyrighted-Material: Please visit http://www.email.it/ita/privacy.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm not a developer, but I've noticed that EVERY kernel version
later than 2.6.7 (excluding that) have a bug when burning any audio cd,
causing bad "jumps" every second or so...

I maintained the same conf. from 2.6.2 to 2.6.8.1 (even 2.6.10 is
affected), and even when changing something, no effect.

FYI if you want I can upload an audio sample somewhere.

Any idea?
::Marco::


 
 
 --
 Email.it, the professional e-mail, gratis per te: http://www.email.it/f
 
 Sponsor:
 Giornata faticosa? Rilassati con il Cuscino per Massaggi che vibra!
 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=2742&d=8-2
