Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUBSX1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUBSX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:27:52 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:20587 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267416AbUBSX1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:27:51 -0500
Date: Thu, 19 Feb 2004 15:21:56 -0800
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeonfb problem
Message-ID: <20040219232156.GN14929@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de> <20040217203604.GA19110@dreamland.darkstar.lan> <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org> <20040217213441.GA22103@dreamland.darkstar.lan> <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org> <1077056532.1076.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077056532.1076.27.camel@gaston>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 09:22:12AM +1100, Benjamin Herrenschmidt wrote:
> Ugh ? Send me a dmesg log at boot please without any command
> line. radeonfb should set your display to the native panel size
> by default

Hmm, this is a bit offtopic, Ben, but do you know why my flat panel
using radeonfb spews half a screenful of junk onto the screen when
switching to FB mode at boot time, which later scrolls away?

It's been a problem since as far back as 2.5.59.

My Mobility Radeon is a M6 LY. If you need any other information such as
kernel config and dmesg, sorry, I'm without my laptop right now as I'm
across the country visiting Carnegie Mellon... you'd have to wait until
Saturday. Just wanted to let you know of the issue.

-- 
Joshua Kwan
