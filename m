Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWBJQGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWBJQGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWBJQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:06:10 -0500
Received: from 8.ctyme.com ([69.50.231.8]:62167 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751275AbWBJQGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:06:08 -0500
Message-ID: <43ECB9EA.9000804@perkel.com>
Date: Fri, 10 Feb 2006 08:06:02 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ata1: command 0x35 timeout sata_nv driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there still problems with sata_nv?

Running 2 maxtor 250gig drives with 16mb buffer.

Getting this error:
ata1: command 0x35 timeout, stat 0x50 hos_stat 0x24
ata2: command 0x35 timeout, stat 0x50 hos_stat 0x24

I really don't think I have 2 bad drives. Asus MB - A8N-VM CSM nVidia 
chip set.
Running 2.6.15 kernel from Fedora Core 4.

Thanks in advance ...
