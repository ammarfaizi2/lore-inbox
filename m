Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWBTOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWBTOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWBTOP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:15:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58787 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964929AbWBTOP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:15:56 -0500
Subject: libata PATA drivers patch for 2.6.16-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Feb 2006 14:19:42 +0000
Message-Id: <1140445182.26526.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various fixes and cleanups, some new functionality notably Promise
20246/2026x support which although basic should get it going with disk.
Not 100% sure about ATAPI on PDC2026x yet.

http://zeniv.linux.org.uk/~alan/IDE


