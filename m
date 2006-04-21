Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWDUTRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWDUTRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDUTRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:17:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932128AbWDUTRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:17:01 -0400
Date: Fri, 21 Apr 2006 21:16:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: luming.yu@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: acpi hotkey sysfs support
Message-ID: <20060421191632.GF2078@elf.ucw.cz>
References: <20060419130719.GA2599@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419130719.GA2599@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have created a place under sysfs to have a unified place
> to gather user input for common hotkey features. 
> http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
> 
> All of you are owner of a specific acpi hotkey driver. 
> Would you like to use that sysfs support to reduce the
> unnecessary interface complexity.

Yep, patch looks okay. It would be nice to format it linux-like,
through. Space between if and (, and such stuff.

SHOUTING_TYPEDEFS look bad to me, too.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
