Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWFZOBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWFZOBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWFZOBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:01:39 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:11166 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1030220AbWFZOBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:01:38 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261355.k5QDtcTm013419@wildsau.enemy.org>
Subject: finding pci_dev from scsi_device
To: linux-kernel@vger.kernel.org
Date: Mon, 26 Jun 2006 15:55:38 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good day,

Could someone please tell me how to find the corresponding
"struct pci_dev *" from a given "struct scsi_device *"?

I've been searching through structures/header files now for
quite some time, but cannot find anything.

thanks in advance,
h.rosmanith

