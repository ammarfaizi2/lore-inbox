Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268439AbTCCQXq>; Mon, 3 Mar 2003 11:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbTCCQXq>; Mon, 3 Mar 2003 11:23:46 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:50561 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S268439AbTCCQXp>;
	Mon, 3 Mar 2003 11:23:45 -0500
Message-ID: <3E6383DD.6090301@walrond.org>
Date: Mon, 03 Mar 2003 16:33:33 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Dmesg: Use a PAE enabled kernel
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]> <3E6381B9.4090708@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm

free suggests I only have about 3Gb...

hal3 root # free -m
         total       used       free     shared    buffers     cached
Mem:     3029       1843       1186          0          0       1696

I assume this means the hole is bigger than 256Mb? :(

