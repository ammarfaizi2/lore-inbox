Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVLETFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVLETFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVLETFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:05:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34948 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751425AbVLETFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:05:53 -0500
Date: Mon, 5 Dec 2005 14:20:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Greg KH <greg@kroah.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051205132048.GB7478@elf.ucw.cz>
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com> <386F0C1C.1040509@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386F0C1C.1040509@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  ..preparing for standby...
>  ..hdd stops spinning..
>  ..monitor is turned off..
>  ..less-than-a-secound-pause..
>  Back to C!
>  ..the system goes back, restoring interrupts etc...
> 
> I tried various 'wakeup' settings in bios, incl. turning everything
> off in that menu - no difference.
> 
> The same behaviour is shown by all 2.6 kernels I tried so far
> (since 2.6.6 or so).

Try ACPI wakeup settings, and ask on ACPI lists. Unfortunately noone
really cares about standby these days.
								Pavel

-- 
Thanks, Sharp!
