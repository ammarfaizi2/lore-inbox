Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbULOTA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbULOTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbULOTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:00:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46058 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262443AbULOTAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:00:51 -0500
Message-ID: <41C089DD.1040208@us.ltcfwd.linux.ibm.com>
Date: Wed, 15 Dec 2004 19:00:45 +0000
From: wendy xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6 kernel] src/linux/drivers/serial: new serial driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are submiting a new serial driver for the 2.6 kernel. This device 
driver is for the Digi Neo serial port adapter.

We made some changes based on great comments from linux community. We 
used the Russell's serial_core interface, handled all initilization of 
module correctly and used fs/seq_file.c interface for /proc entry.

I put the driver on our website:
http://www-124.ibm.com/linux/patches/?patch_id=1672

Thank you very much!
wendy

