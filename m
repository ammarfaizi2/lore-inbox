Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTKJXcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTKJXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:32:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34052 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263269AbTKJXch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:32:37 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Floppy in 2.6
Date: 10 Nov 2003 23:21:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop6im$7md$1@gatekeeper.tmr.com>
References: <20031028232054.1d452baa.news.receive@zoznam.sk> <yw1xekwxx9vf.fsf@kth.se>
X-Trace: gatekeeper.tmr.com 1068506518 7885 192.168.12.62 (10 Nov 2003 23:21:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yw1xekwxx9vf.fsf@kth.se>,
=?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se> wrote:
| Jakub Krajcovic <news.receive@zoznam.sk> writes:
| 
| > In 2.4 there was the option for "normal floppy support" and I have the
| > /dev/fd0 device for my floppy when I boot the old 2.4.22 kernel. So my
| > question is: does the 2.6 kernel support normal floppy disks or not?
| > And if it does, how do I enable this support in order to use my floppy
| > drive.
| 
| It's there.  In menuconfig it's "Device Drivers" -> "Block devices" ->
| "Normal floppy disk support".
| 
| Who uses floppy disks nowadays, anyway?

People who are non-power users, people who support hardware devices
which use them and which cost too much to scrap and replace.

If I could find a good way to attach old 8 inch floppies to a PC using
reasonably available hardware I would, it would allow me to retire what
I use now. Since there's money in being able to do that, I do.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
