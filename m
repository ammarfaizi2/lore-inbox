Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTLGUmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTLGUmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:42:52 -0500
Received: from gprs148-118.eurotel.cz ([160.218.148.118]:23680 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264513AbTLGUmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:42:51 -0500
Date: Sun, 7 Dec 2003 18:26:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High-pitch noise with 2.6.0-test11
Message-ID: <20031207172653.GA379@elf.ucw.cz>
References: <1070605910.4867.9.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070605910.4867.9.camel@idefix.homelinux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just installed 2.6.0-test11 on my Dell Latitude D600 (Pentium-M)
> laptop and I noticed a strange high-pitch noise comming from the laptop
> itself (that wasn't there with 2.4). The noise happens only when the CPU
> is idle. Also, I have noticed that removing thermal.o makes the noise
> stop, which is very odd. Is there anything that can be done about that?

I'm afraid this is common prolem; most notebooks I sen do some kind of
annoying noise under some circumstances. Therewas technical discussion
about why that happens on ACPI list.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
