Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTKARMC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 12:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTKARMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 12:12:02 -0500
Received: from web60207.mail.yahoo.com ([216.109.118.102]:58789 "HELO
	web60207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263280AbTKARMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 12:12:00 -0500
Message-ID: <20031101171159.11330.qmail@web60207.mail.yahoo.com>
Date: Sat, 1 Nov 2003 09:11:59 -0800 (PST)
From: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Subject: can someone PLEASE address this bug?(usb keyboard)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have posted and posted about this bug, introduced
around test3, because unplugging and replugging my
keyboard gets really old after a while.  I had figured
whoever introduced it would fix it.  That didn't
happen, so I figured someone else would fix it after
submitting a bug report, but no, it continued to make
the next release.

PLEASE, I am not trying to be rude, but I do not know
how else to report that this is, in fact a bug


http://bugzilla.kernel.org/show_bug.cgi?id=1229

with my uhci interface, it will either turn off after
a while(the keyboard completely) or all the lights go
on(Reset?) and the keycodes go screwy.  On my ohci
interface(usb 2 card) the former still happens.

PLEASE

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
