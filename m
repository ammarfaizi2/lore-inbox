Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbSLRTZq>; Wed, 18 Dec 2002 14:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbSLRTZp>; Wed, 18 Dec 2002 14:25:45 -0500
Received: from cynosure.colorado-research.com ([65.171.192.72]:21638 "EHLO
	cynosure.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267406AbSLRTZU>; Wed, 18 Dec 2002 14:25:20 -0500
Message-ID: <3E00CD75.6080107@cora.nwra.com>
Date: Wed, 18 Dec 2002 12:33:09 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manish Lachwani <manish@Zambeel.com>
CC: "''scott@thomasons.org ' '" <scott@thomasons.org>,
       "''Alan Cox ' '" <alan@lxorguk.ukuu.org.uk>,
       "''Linux Kernel Mailing List ' '" <linux-kernel@vger.kernel.org>
Subject: Re:hanging system
References: <233C89823A37714D95B1A891DE3BCE5202AB1B32@xch-a.win.zambeel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Lachwani wrote:

> I had found problems when using burnk6 on the CPUs. After running
> burnk6 for severl hrs, the CPUs used to get underclocked on bootup. I
> had also noticed occasional hangs on such CPUs
>

Well, burnK7 crashes this system pretty easily (few minutes).  I also 
get "254" error codes from it which apparently indicate an 
"integer/memory error".

I've been trying to run "sensors" (from lm_sensors) to see if I can see 
and voltage or temp issues while burnK7 is running, but I'm skeptical 
that the temp readings are correct as they aren't moving much.

- Orion



