Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCaR1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbUCaR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:26:10 -0500
Received: from fmr02.intel.com ([192.55.52.25]:17840 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262254AbUCaRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:25:51 -0500
Subject: Re: Linux 2.6.5-rc3 - ALI15X3, irq 15: nobody cared! / Disabling
	IRQ #15
From: Len Brown <len.brown@intel.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6E02@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6E02@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080753945.21276.4.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2004 12:25:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 14:40, Helge Deller wrote:
> IBM R30 Laptop, ALI15X3 IDE onboard chip, internal IDE harddisk &
> CDROM gives
>  irq 15: nobody cared!
>  ....
>  Disabling IRQ #15

Did 2.6.5-rc2 work okay?

Nothing ACPI jumps out at me here, but if you boot with acpi=off
or pci=noacpi and the problem goes away, then let me know.

thanks,
-Len

