Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWGaXDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWGaXDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWGaXDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:03:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2449 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030377AbWGaXDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:03:39 -0400
Date: Tue, 1 Aug 2006 01:01:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jean Delvare <khali@linux-fr.org>
Cc: Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>
Subject: Re: Generic battery interface
Message-ID: <20060731230145.GF3612@elf.ucw.cz>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com> <20060728202359.GB5313@suse.cz> <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com> <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com> <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com> <20060731233536.92b39035.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731233536.92b39035.khali@linux-fr.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> frequently it can read from the chip. And no hardware monitoring chip I
> know of can tell when the monitored value has changed - you have to read
> the chip registers to know.

ACPI battery can tell when values change in significant way. (Like
battery becoming critical).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
