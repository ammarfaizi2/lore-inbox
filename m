Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWBJANu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWBJANu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWBJANu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:13:50 -0500
Received: from 8.ctyme.com ([69.50.231.8]:25280 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1750860AbWBJANt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:13:49 -0500
Message-ID: <43EBDABC.80909@perkel.com>
Date: Thu, 09 Feb 2006 16:13:48 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ata1: command 0x35 timeout sata_nv 
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


