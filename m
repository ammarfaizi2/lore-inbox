Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWEWIn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWEWIn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWEWIn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:43:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6021 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932130AbWEWIn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:43:57 -0400
Date: Tue, 23 May 2006 10:39:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, kristen.c.accardi@intel.com
Subject: [-mm] oops during boot, in dock-related code
Message-ID: <20060523083908.GA1604@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'll try to turn off CONFIG_ACPI_DOCK to see if it helps... yes it
does.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
