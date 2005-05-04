Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVEDRd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEDRd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEDRcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:32:51 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:46476 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261256AbVEDRaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:30:20 -0400
Date: Wed, 4 May 2005 19:31:13 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1416215015.20050504193114@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: ata over ethernet question
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

AOE is a bit new for me.

Would it be possible to use tha AOE driver to
attach one ATA drive in a host over ethernet to another
host ? Or is it support for specific hardware devices only?

You know, something like:
# fdisk <device_on_another_host>
# mkfs.ext2 <device_on_another_host/partition1>
# mount <device_on_another_host/partition1> /mnt/part1

--
Maciej


