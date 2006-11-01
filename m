Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946827AbWKAL43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946827AbWKAL43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946808AbWKAL43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:56:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51102 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423976AbWKAL42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:56:28 -0500
Date: Wed, 1 Nov 2006 12:56:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kristen.c.accardi@intel.com, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: acpiphp makes noise on every lid close/open
Message-ID: <20061101115618.GA1683@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With 2.6.19-rc4, acpi complains about "acpiphp_glue: cannot get bridge
info" each time I close/reopen the lid... On thinkpad x60. Any ideas?
(-mm1 behaves the same).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
