Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUENRU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUENRU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUENRU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:20:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261798AbUENRU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:20:27 -0400
Message-ID: <40A4FFCD.7040704@pobox.com>
Date: Fri, 14 May 2004 13:20:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>
Subject: [RFT] acenic net driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph was kind enough to convert acenic to use the PCI API.

Can someone with an acenic card download Andrew Morton's -mm tree (which 
contains Christoph's work), and verify that the driver still works?

Nothing elaborate required, just wanted to make sure nothing was broken 
in the conversion to PCI API.

Thanks,

	Jeff




