Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTJZK0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTJZK0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:26:04 -0500
Received: from quechua.inka.de ([193.197.184.2]:26046 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262736AbTJZK0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:26:01 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: suspend works fine
Date: Sun, 26 Oct 2003 11:25:56 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.26.10.25.55.369925@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test9, swsusp (the kernel one, not the 2.0alpha patch).
works very fine. as usual video playback with mplayer&co
had a problem, but starting another XFree86 and quiting it
solved that.

I was using pcmcia, a wireless lan card with hostap driver
(0.1.0, kernel patched for that), and did not stop anything
or remove any module. still everything works very fine.
also I was using X, did not switch to console before suspending,
and it worked fine. great!

For reference: it's a dell latitude c600 notebook.
If you have one of these, swsusp should work fine for you, too.

Regards, Andreas

