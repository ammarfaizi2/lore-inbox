Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWDVTQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWDVTQw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWDVTQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:16:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56332 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750974AbWDVTQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:06 -0400
Date: Thu, 20 Apr 2006 21:56:52 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420215652.GB2352@ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419195356.GA24122@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sleep and power buttons are logically part of the keyboard, and it makes 
> for them to be exposed via an input device rather than an odd file in 
> /proc. This patch adds a keycode for lid switches (are we running out of 
> keycodes?) and allows the button driver to register an input device.

Yes, please. This is actually long overdue.

								Pavel

-- 
Thanks, Sharp!
