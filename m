Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWCILvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWCILvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCILvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:51:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751824AbWCILvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:51:02 -0500
Date: Thu, 9 Mar 2006 12:50:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15.6][suspend] sleeping function called from invalid context on swsusp resume from STR
Message-ID: <20060309115050.GA3167@elf.ucw.cz>
References: <200603090820.36867.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603090820.36867.arvidjaar@mail.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 09-03-06 08:20:36, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I get this when resuming from swsup STR. I wonder if this may possibly account 
> for hard lockups I have been experiencing with acpi_cpufreq (see "System 
> completely hangs using acpi_cpufreq").

This warning is known and harmless (just hard to fix nicely).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
