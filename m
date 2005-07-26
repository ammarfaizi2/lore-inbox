Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVGZTjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGZTjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGZTju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:39:50 -0400
Received: from [216.148.227.85] ([216.148.227.85]:36491 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261747AbVGZTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:39:44 -0400
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
From: Len Brown <len.brown@intel.com>
To: Cameron Harris <thecwin@gmail.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <b6d0f5fb0505220425146d481a@mail.gmail.com>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 15:44:39 -0400
Message-Id: <1122407079.13241.4.camel@toshiba.lenb.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 07:25 -0400, Cameron Harris wrote:
> I just upgraded from 2.6.11.3 and now my /proc/acpi/button directory
> doesn't exist...

I deleted /proc/acpi/button on purpose,
did you have a use for those files?

Note that over time everything in /proc/acpi is
going away.  In this case, there didn't seem to be
a case for making appear in /sys.

thanks,
-Len


