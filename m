Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTGUIfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 04:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbTGUIfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 04:35:54 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:5545 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S269439AbTGUIfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 04:35:50 -0400
Date: Mon, 21 Jul 2003 10:50:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.0: characters repeated when *pasting*?!
Message-ID: <20030721085027.GA305@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I copied text ole.rohne@cern.ch (using gpm), pasted it to emacs (right
mouse button) in another console and it came out as
oooooole.rohne@cern.ch. That looks extremely weird and suggests that
repeated characters are indeed software problem.

Its not reproducible, and nothing interesting in logs :-(.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

