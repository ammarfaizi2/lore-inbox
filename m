Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSKPALn>; Fri, 15 Nov 2002 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSKPALn>; Fri, 15 Nov 2002 19:11:43 -0500
Received: from f101.pav1.hotmail.com ([64.4.31.101]:22288 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266952AbSKPALk>;
	Fri, 15 Nov 2002 19:11:40 -0500
X-Originating-IP: [199.1.46.3]
From: "Mehdi Hashemian" <mhashemian@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: High Memory question
Date: Fri, 15 Nov 2002 16:18:31 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F101LYLFlELHRAAfbO50000e6bf@hotmail.com>
X-OriginalArrivalTime: 16 Nov 2002 00:18:32.0202 (UTC) FILETIME=[B2174EA0:01C28D05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Going through different parts of Kernel, I am trying to figure out if I need 
to change /page.h/__PAGE_OFFSET to some smaller value when compiling with 
CONFIG_HIGHMEM4G option to support more than 1G physical memory. Other than 
that, I can not figure out how virtual address for vmalloc and ioremap are 
going to fit above logical addresses.

Any comment appreciated!
Mehdi


_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

