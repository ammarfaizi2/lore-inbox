Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUHOTMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUHOTMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHOTMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 15:12:43 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:50571 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266821AbUHOTMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 15:12:37 -0400
Message-ID: <411FB612.9000103@drzeus.cx>
Date: Sun, 15 Aug 2004 21:14:26 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rmk+lkml@arm.linux.org.uk
Subject: MMC in vanilla kernel
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In April there were some patches from Russell King to add MMC support 
into the vanilla kernel. The latest version (2.6.8.1) does not have 
these patches included and I haven't found any more comments about it on 
the list. As I am in the middle of reverse engineering the Windows 
driver for a MMC/SD card reader I'd like to integrate my work with these 
routines. So what is the status of getting them into Linus' kernel and 
is the patch set from april the latest version of the routines?

Rgds
Pierre Ossman

