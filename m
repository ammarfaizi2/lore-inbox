Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbWBUVMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbWBUVMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWBUVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:12:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56796 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932779AbWBUVMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:12:17 -0500
Date: Tue, 21 Feb 2006 22:12:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
       mjg59@srcf.ucam.org
Subject: suspend to ram: request for testing
Message-ID: <20060221211207.GA22592@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In www.sf.net/projects/suspend 's CVS, there is a new version of s2ram
program. Now it includes vbetool, and long whitelist copied from
acpi_support-0.52 (thanks!).

Unlike using Doc*/power/video.txt stuff, where you need to configure
command line and/or set up scripts, it should just work. It if does
not, it should be easy to add your machine into whitelist.

Please test,

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
