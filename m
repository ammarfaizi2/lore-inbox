Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUDQHwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 03:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDQHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 03:52:53 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:23007 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261604AbUDQHww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 03:52:52 -0400
Message-ID: <4080E1A1.7030606@superonline.com>
Date: Sat, 17 Apr 2004 10:49:53 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA support in 2.4.27
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments in  ChangeSet 1.1366 -> 1.1367  say:

# This adds all the SATA drivers except Intel ICH5/ICH6 ("ata_piix").
# ata_piix was the cause of all the ____request_resource() and PCI quirk
# nastiness.  As you can see, without that driver, the patch is nice and
# clean, and does nothing but add files.

Shall we people who can stand unclean and ugly trees have a separate
patch for ata_piix please ;))

Regards;
Özkan Sezer

