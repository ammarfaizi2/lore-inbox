Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUASUXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbUASUXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:23:17 -0500
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:60296 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S263513AbUASUXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:23:15 -0500
Message-ID: <400C3CEA.1060004@us.ibm.com>
Date: Mon, 19 Jan 2004 15:24:10 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com
Subject: [PATCH] IBM PowerPC Virtual Ethernet Driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that adds the inter-partition Virtual Ethernet driver for 
newer IBM iSeries and pSeries systems:

http://www-124.ibm.com/linux/patches/ppc64/ibmveth.patch

The patch applies against the 2.4.25-pre6 tree...

Jeff, can you formally add this driver to 2.4?... I'm waiting for some
ppc64 architectural addition to send out the driver for 2.6...

Comments and suggestions are always welcome...
-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

