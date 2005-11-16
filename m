Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVKPUOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVKPUOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKPUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:14:29 -0500
Received: from intranet.networkstreaming.com ([24.227.179.66]:25259 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932296AbVKPUO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:14:29 -0500
Message-ID: <437B932F.3090607@davyandbeth.com>
Date: Wed, 16 Nov 2005 14:14:39 -0600
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: virtual NICs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2005 20:13:56.0765 (UTC) FILETIME=[460114D0:01C5EAEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Curious question:

  If I configure multiple IP addresses to a NIC, and assign 1.2.3.4 to 
eth0 and 5.6.7.8 to eth0:0 (a virtual NIC) is there extra work involved 
on the part of the CPU or memory or whatever in routing traffic via 
5.6.7.8 than 1.2.3.4.. I mean does one IP have an advantage over the 
other in any sense?

Thanks,
  Davy
