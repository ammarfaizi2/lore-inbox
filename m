Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTLHQqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTLHQkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:40:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55301 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265485AbTLHQdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:33:12 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: cdrecord hangs my computer
Date: 8 Dec 2003 16:21:54 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br28f2$fen$1@gatekeeper.tmr.com>
References: <20031207110122.GB13844@zombie.inka.de> <Pine.LNX.4.58.0312070812080.2057@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1070900514 15831 192.168.12.62 (8 Dec 2003 16:21:54 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312070812080.2057@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:

| In contrast, the old cdrecord interfaces are an UNBELIEVABLE PILE OF CRAP!
| It's an interface that is based on some random hardware layout mechanism
| that isn't even TRUE any more, and hasn't been true for a long time. It's
| not helpful to the user, and it doesn't match how devices are accessed by
| everything else on the system.
| 
| It's bad from a technical standpoint (anybody who names a generic device
| with a flat namespace is just basically clueless), and it's bad from a
| usability standpoint. It has _zero_ redeeming qualities.

And the redeeming features of naming disks, CDs, and ide-floppy devices
hda..hdx in an order depending on the loading order of the device
drivers?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
