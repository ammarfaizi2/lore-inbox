Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290172AbSAKXvs>; Fri, 11 Jan 2002 18:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290174AbSAKXvi>; Fri, 11 Jan 2002 18:51:38 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:10502 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290172AbSAKXvS>;
	Fri, 11 Jan 2002 18:51:18 -0500
Date: Fri, 11 Jan 2002 15:48:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI PCI Hotplug driver shell
Message-ID: <20020111234834.GB2289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've make a patch against 2.5.2-pre11 that is the shell of the ACPI PCI
Hotplug driver.  It is basically a skeleton pci_hotplug driver, with
lots of /* FIXME */ sections for where to place the ACPI support.

I'm going to continue to work on this driver, but wanted to make a
release to let everyone else have something to start playing with, and
to let people know that this work is actually going on :)

The patch can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/hotplug/pcihp_acpi-2.5.2-pre11.patch

thanks,

greg k-h
