Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVKXKpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVKXKpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKXKpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:45:21 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:1242 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030363AbVKXKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:45:19 -0500
Date: Thu, 24 Nov 2005 11:45:38 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Chris Boot <bootc@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc2-mm1 problems
Message-ID: <20051124104538.GB6788@stiffy.osknowledge.org>
References: <3F1A9A2D-4726-42E9-A971-68F2B2782900@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1A9A2D-4726-42E9-A971-68F2B2782900@bootc.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Boot <bootc@bootc.net> [2005-11-23 23:45:49 +0000]:

> On another note, I can't get the binary nVidia drivers to work, they  
> complain about the following unresolved symbols:
> 
> [4294682.396000] nvidia: module license 'NVIDIA' taints kernel.
> [4294682.396000] nvidia: Unknown symbol pci_enable_device
> [4294682.396000] nvidia: Unknown symbol pci_dev_put
> [4294682.396000] nvidia: Unknown symbol pci_get_device
> [4294682.396000] nvidia: Unknown symbol __pci_register_driver
> [4294682.396000] nvidia: Unknown symbol pci_bus_write_config_byte
> [4294682.396000] nvidia: Unknown symbol pci_unregister_driver
> [4294682.396000] nvidia: Unknown symbol pci_bus_read_config_dword
> [4294682.396000] nvidia: Unknown symbol pci_bus_read_config_word
> [4294682.396000] nvidia: Unknown symbol pci_bus_write_config_dword
> [4294682.397000] nvidia: Unknown symbol pci_set_master
> [4294682.397000] nvidia: Unknown symbol pci_bus_write_config_word
> [4294682.397000] nvidia: Unknown symbol pci_get_class
> [4294682.397000] nvidia: Unknown symbol pci_disable_device
> [4294682.397000] nvidia: Unknown symbol pci_bus_read_config_byte
> 

http://www.nvnews.net/vbulletin/forumdisplay.php?s=&forumid=14
