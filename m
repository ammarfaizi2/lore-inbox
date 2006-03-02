Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWCBPOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCBPOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCBPOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:14:08 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4008 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750956AbWCBPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:14:06 -0500
Message-ID: <44070B62.3070608@jp.fujitsu.com>
Date: Fri, 03 Mar 2006 00:12:34 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Greg,

Here is an updated set of patches for PCI legacy I/O port free
driver. It incorporates all of the feedbacks. I rebased it against the
latest -mm kernel (2.6.16-rc5-mm1).

Could you consider applying this to -mm tree?

Thanks,
Kenji Kaneshige
