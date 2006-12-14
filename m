Return-Path: <linux-kernel-owner+w=401wt.eu-S1751932AbWLNQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWLNQsl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWLNQsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:48:41 -0500
Received: from hera.kernel.org ([140.211.167.34]:56437 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbWLNQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:48:40 -0500
Date: Thu, 14 Dec 2006 16:48:37 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.33.5
Message-ID: <20061214164837.GA13412@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is Linux 2.4.33.5. It mostly fixes 2 minor vulnerabilities :

CVE-2006-5871 (smbfs) don't ignore uid/gid/mode mount opts w/ unix extensions
CVE-2006-6106 (Bluetooth) add packet size checks for CAPI messages

It's now up to date with the changes in 2.4.34-rc2.

Regards,
Willy

Summary of changes from v2.4.33.4 to v2.4.33.5
============================================

dann frazier (1):
      smbfs : don't ignore uid/gid/mode mount opts w/ unix extensions

Marcel Holtmann (1):
      [Bluetooth] Add packet size checks for CAPI messages (CVE-2006-6106)

Oliver Neukum (2):
      fix for transient error in usb printer driver
      task stte leak in pegasus usb driver

Shaohua Li (1):
      x86 microcode: dont check the size

Willy Tarreau (1):
      Change VERSION to 2.4.33.5

