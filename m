Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWIDWJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWIDWJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWIDWJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:09:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30433 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751492AbWIDWJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:09:30 -0400
Date: Mon, 4 Sep 2006 23:40:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: x60 - spontaneous thermal shutdown
Message-ID: <20060904214059.GA1702@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

x60 shut down after quite a while of uptime, in period of quite heavy
load:

Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
Sep  4 23:34:42 amd init: Switching to runlevel: 0

I do not think cpu reached 128C, as I still have my machine... Did
anyone else see that?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
