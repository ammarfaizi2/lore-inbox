Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTJIWTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJIWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:19:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14097 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262101AbTJIWTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:19:16 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: devfs and udev
Date: 9 Oct 2003 22:09:33 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4mat$6ld$1@gatekeeper.tmr.com>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <20031007205244.GA2978@kroah.com> <yw1xvfr0wxfa.fsf@users.sourceforge.net> <20031007213758.GB3095@kroah.com>
X-Trace: gatekeeper.tmr.com 1065737373 6829 192.168.12.62 (9 Oct 2003 22:09:33 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031007213758.GB3095@kroah.com>,
Greg KH  <linux-kernel@vger.kernel.org> wrote:

| mount -t ramfs none /dev
| 
| That is what udev will run off of :)
| 
| Again, can you point me to any documentation that states that udev will
| do this on a persistant filesystem?

I'm going back to look again, but I don't recall that it won't, either.
If it wants a ramfs on /dev, why doesn't it just create one? That's a
question, not an argument! I had assumed it would run on a persistent
f/s if present.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
