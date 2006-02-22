Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWBVTR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWBVTR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWBVTR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:17:29 -0500
Received: from fmr20.intel.com ([134.134.136.19]:54733 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751115AbWBVTR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:17:27 -0500
Subject: [patch 0/3] New dock patches
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com,
       pavel@ucw.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 11:21:21 -0800
Message-Id: <1140636081.32574.18.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 22 Feb 2006 19:16:06.0570 (UTC) FILETIME=[6E16D8A0:01C637E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is a new set of docking station patches which replaces
the old docking station patches.  It applies to 2.6.16-rc4-mm1.  It
is new and improved over the old version, in that it can now handle
laptops which define docking stations outside of the scope of PCI.

Thanks to everyone who provided feedback on the original patches, and
especially to Pavel who is the only brave soul to test these patches
out so far :).  As always, I would appreciate feedback on these 
patches.

Kristen
