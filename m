Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSGSXba>; Fri, 19 Jul 2002 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSGSXba>; Fri, 19 Jul 2002 19:31:30 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20233 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317217AbSGSXba>;
	Fri, 19 Jul 2002 19:31:30 -0400
Date: Fri, 19 Jul 2002 16:32:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] ACPI PCI Hotplug driver update for 2.4.19-rc2-ac2
Message-ID: <20020719233256.GE24044@kroah.com>
References: <20020719192313.GD22862@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719192313.GD22862@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 22:08:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note:  This was previously sent to Alan Cox with the patch inline, but
didn't make it to the mailing lists due to the size of the patch.


Hi,

Here's a patch against 2.4.19-rc2-ac2 that updates the ACPI PCI Hotplug
driver to the latest version.  This patch was written by Takayoshi KOCHI
<t-kouchi@mvf.biglobe.ne.jp> and has been tested on some IBM i386, NEC
i386, and some unnammed ia64 machines.

thanks,

greg k-h

Patch can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/hotplug/2.4/pci_hp-acpi-2.4.19-rc2-ac2.patch

