Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264534AbUDULlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUDULlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUDULlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:41:50 -0400
Received: from smtp.server-home.net ([195.137.212.50]:33039 "EHLO
	smtp.server-home.net") by vger.kernel.org with ESMTP
	id S264534AbUDULlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:41:49 -0400
Message-ID: <40865DFD.9000405@domainbox.de>
Date: Wed, 21 Apr 2004 13:41:49 +0200
From: Jason Brian Friedrich <jf@domainbox.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Kernel 2.4.26] Booting from Adaptec PCI-X 133 29320 Rev C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2004 11:44:47.0609 (UTC) FILETIME=[0C2D4E90:01C42796]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

we can not boot from an "Adaptec PCI-X 133 29320 Rev C" device when 
using 2.4.26. We get a kernel panic and that the kernel could not 
mount root (VFS: Unable to mount root fs on 08:03). With 2.4.25 
everything works properly (its the same config) but we need the 
security patches included in 2.4.26.

I have not found any entries in the changelog about changes in the 
scsi drivers.

Thanks in advance,

Jason Brian Friedrich
