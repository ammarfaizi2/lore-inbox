Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWJUWtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWJUWtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJUWtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 18:49:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:9954 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161150AbWJUWtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 18:49:01 -0400
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: Please pull two more bug fixes for x86-64
Date: Sun, 22 Oct 2006 00:48:54 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610220048.54641.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, two more bug fixes for x86-64

Please pull from

  git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

Muli Ben-Yehuda:
      x86-64: increase PHB1 split transaction timeout

Andi Kleen:
      x86-64: Fix C3 timer test	

 arch/x86_64/kernel/pci-calgary.c |   44 +++++++++++++++++++++++++++++++++++++-
 arch/x86_64/kernel/time.c        |    2 +-

