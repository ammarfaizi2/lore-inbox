Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWBHJKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWBHJKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWBHJKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:10:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161075AbWBHJKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:10:04 -0500
Date: Wed, 8 Feb 2006 10:07:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Message-ID: <20060208090757.GB11895@elf.ucw.cz>
References: <20060207133456.GA2452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207133456.GA2452@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The included patch adds support for interacting with the toshiba_acpi 
> backlight control through the generic backlight interface 
> (/sys/class/backlight).
> 
> ACPI folk: this gives us the benefit of a consistent interface to LCD 
> brightness. Is it worth me converting the other drivers over?

Not sure if I'm ACPI folk but yes, consistent interface would be nice.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
