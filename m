Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCEWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCEWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCEWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:01:25 -0500
Received: from mail.suse.de ([195.135.220.2]:65410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261212AbVCEWBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:01:21 -0500
Message-ID: <422A2C29.8070209@suse.de>
Date: Sat, 05 Mar 2005 23:01:13 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>
Subject: Re: s4bios: does anyone use it?
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org>
In-Reply-To: <422A1FB6.3000504@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:

>  From what I remember, I didn't see any difference between S4 and S4Bios in
> recent vanilla kernels.

I have seen exactly the same thing and concluded that S4bios is broken.
Since it is tricky to set up (you usually need a special hibernation
partition or a special file in a FAT partition) and probably slow as
hell (at least if it has anything to do with the APM BIOS suspend to
disk routines, and i assume it does), i'd shed no tears if it would go
away ;-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
