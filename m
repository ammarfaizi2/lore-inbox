Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUFSUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUFSUuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUFSUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:50:37 -0400
Received: from v2.gawab.com ([204.97.230.42]:34246 "HELO gawab.com")
	by vger.kernel.org with SMTP id S264660AbUFSUug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:50:36 -0400
Message-ID: <20040619205038.27491.qmail@gawab.com>
From: "AshMilsted" <thatistosayiseenem@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-ck1
Date: Sat, 19 Jun 2004 20:50:38 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [212.159.119.65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.7-ck1 is very useable on my Celeron 500 (medochino) system
(using cfq I/O sched). It seems more responsive than the recent
stock kernels, and staircase 7.0/7.1 is a big improvement over
6.3, which stalled in annoying places. In fact, the only problem
I have with the patchset is that when I run foobar2000 under
wine the sound skips when I load a new web page in epiphany. If
I make wine an ISO task with schedtool then it no longer skips,
but it also hangs the system for a few seconds while browsing
the foobar preferences dialogue. I guess I'll have to keep a
launcher without schedtool ready for when I need to mess with
the prefs for now.
Anyway, great work - makes this old system seem that little bit
snappier.

-Ash

PS: I'm not subscribed to the list, so please CC me if you reply
to this.
________________________________
15 Mbytes Free Web-based and  POP3
Sign up now: http://www.gawab.com
