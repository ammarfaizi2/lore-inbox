Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031167AbWI0WgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031167AbWI0WgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031165AbWI0WgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:36:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:14683 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031163AbWI0WgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:36:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,226,1157353200"; 
   d="scan'208"; a="137313347:sNHT25080881"
Date: Wed, 27 Sep 2006 15:36:19 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net, jgarzik@pobox.com
Subject: [patch 0/2] libata: Return of the ACPI Patches
Message-Id: <20060927153619.b4126a63.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
These are patches that use ACPI to help reinitialize SATA drivers
on resume.  They were created and first submitted by Randy Dunlap last
year, and then again by Forrest Zhao a couple months ago.  And now it's
my turn.  These are against 2.6.18-mm1 - please let me know if you want
me to patch against a different code base.  Hopefully I've captured all
the past feedback, but sorry in advance if I've missed something that's
been said before.

Thanks,
Kristen

--
