Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTASWHC>; Sun, 19 Jan 2003 17:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267712AbTASWHC>; Sun, 19 Jan 2003 17:07:02 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:59060 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267699AbTASWHB>; Sun, 19 Jan 2003 17:07:01 -0500
Message-ID: <3E2B239E.40308@bogonomicon.net>
Date: Sun, 19 Jan 2003 16:15:58 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
References: <Pine.LNX.4.10.10301191327050.12087-100000@master.linux-ide.org> <3E2B1F9E.8030105@tupshin.com>
In-Reply-To: <3E2B1F9E.8030105@tupshin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To me they seam like a candidate for output at a higher
debug level or ide specific debug.  They aren't a driver
setup, odd condition, or error message.

- Bryan

Tupshin Harper wrote:
> Andre Hedrick wrote:
> 
>> Exactly when you want to flush the devices to platter.
>> The problem will be what to do if we get an error on flush-cache.
>>
> Are these "no cach flush required" messages going to be removed? It does 
> clutter up the boot process output pretty badly.

