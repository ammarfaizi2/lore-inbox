Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbRDRTTN>; Wed, 18 Apr 2001 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRDRTTB>; Wed, 18 Apr 2001 15:19:01 -0400
Received: from mail.texoma.net ([209.151.96.3]:61152 "HELO mail.texoma.net")
	by vger.kernel.org with SMTP id <S135263AbRDRTSf>;
	Wed, 18 Apr 2001 15:18:35 -0400
Message-ID: <3ADDE820.2050103@texoma.net>
Date: Wed, 18 Apr 2001 14:16:48 -0500
From: Moses Mcknight <moses@texoma.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; 0.8.1) Gecko/20010323
X-Accept-Language: en
MIME-Version: 1.0
To: Manuel Ignacio Monge Garcia <ignaciomonge@navegalia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ATA 100 & VIA and linux-2.4.3ac8
In-Reply-To: <01041820505300.01783@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know about other possible problems with the kernel, but you must 
use an 80 wire IDE cable for UDMA66/100 to work.

> -----------------------Primary IDE-------Secondary IDE------
> Cable Type:                   40w                 40w


