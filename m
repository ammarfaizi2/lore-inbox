Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265771AbTGII3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTGII3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:29:25 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:40653 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265771AbTGII3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 04:29:24 -0400
Message-ID: <3F0BD5D1.2010801@hawton.org>
Date: Wed, 09 Jul 2003 01:44:01 -0700
From: Daniel <daniel@hawton.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI status in 2.5.x/2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Compaq Laptop (*shiver*) and present distro versions featuring 
the 2.4.x kernel seem to panic or lock on bootup on my laptop.  I was 
wondering if ACPI was better supported in the 2.5.x kernel branch/2.6.0 
pre-kernel.  Any advice would be greatly appreciated.

It would lock when attempting to read my partition table on device 'hda' 
(my hard disk), or would panic when attempting to initalize the USB device.

-Daniel

