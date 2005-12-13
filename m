Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVLMSXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVLMSXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVLMSXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:23:10 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:5162 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030195AbVLMSXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:23:09 -0500
Date: Tue, 13 Dec 2005 13:22:11 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 0/2] Sync Ubuntu patches
In-reply-to: 
To: linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@ubuntu.com>
Reply-to: Ben Collins <bcollins@ubuntu.com>
Message-id: <113449813159-git-send-email-bcollins@ubuntu.com>
MIME-version: 1.0
X-Mailer: git-send-email
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are found in the git repository at:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git#for-linus

Ben Collins:
      asus_acpi: Invert read of wled proc file to show correct state of LED.
      ide/sis5513: Add support for 965 chipset

 drivers/acpi/asus_acpi.c  |   10 +++++-----
 drivers/ide/pci/sis5513.c |    8 +++++++-
 include/linux/pci_ids.h   |    1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

