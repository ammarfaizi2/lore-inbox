Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSGGTdG>; Sun, 7 Jul 2002 15:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSGGTdF>; Sun, 7 Jul 2002 15:33:05 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:19214 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316512AbSGGTdE>;
	Sun, 7 Jul 2002 15:33:04 -0400
Date: Sun, 7 Jul 2002 12:33:31 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI Hotplug changes for 2.5.25
Message-ID: <20020707193331.GA17922@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5


 drivers/hotplug/pci_hotplug_core.c |    5 ++++-
 drivers/hotplug/pci_hotplug_util.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
------

ChangeSet@1.630, 2002-07-07 11:32:52-07:00, greg@kroah.com
  PCI Hotplug: fix the dbg() macro to work properly on older versions of gcc

 drivers/hotplug/pci_hotplug_core.c |    2 +-
 drivers/hotplug/pci_hotplug_util.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.629, 2002-07-07 11:28:15-07:00, greg@kroah.com
  PCI Hotplug: fix i_nlink for root inode in pcihpfs

 drivers/hotplug/pci_hotplug_core.c |    3 +++
 1 files changed, 3 insertions(+)

