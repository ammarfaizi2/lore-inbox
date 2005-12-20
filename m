Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVLTQY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVLTQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVLTQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:24:59 -0500
Received: from 8.ctyme.com ([69.50.231.8]:234 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751110AbVLTQY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:24:58 -0500
Message-ID: <43A8305A.8060402@perkel.com>
Date: Tue, 20 Dec 2005 08:24:58 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Asus A8n-SLI Premium IOMMU Locks up - 2.6.14.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried compiling the 2.6.14.4 kernel to see if the IOMMU problem is still 
there and it is. Same with the latest Fedora stock kernel. Freezes on 
boot up. I remember seeing a discussion of the somewhere. Has this been 
fixed yet?
