Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUGKCee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUGKCee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUGKCee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:34:34 -0400
Received: from fmr01.intel.com ([192.55.52.18]:47825 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266484AbUGKCea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:34:30 -0400
Subject: Re: 2.6.7-mm7
From: Len Brown <len.brown@intel.com>
To: warpy@gmx.de
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFA5D@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFA5D@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089513248.32038.46.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:34:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 07:44, Michael Geithe wrote:
> Am Freitag, 9. Juli 2004 08:50 schrieben Sie:
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
> Hi,
> reverting bk-usb.patch makes it boot.
> 
> Shutdown will not work with the latest bk-acpi.patch in mm7.
> Stops with 
> 
> Power down
> acpi_power_off called

When you revert bk-acpi.patch shutdown works?
did it work in stock 2.6.7?
If yes, does it work with stock 2.6.7 + bk-acpi.patch?

any change if you boot latest -mm with "acpi_os_name=Linux"?

thanks,
-Len


