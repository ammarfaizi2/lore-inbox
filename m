Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHTU17>; Mon, 20 Aug 2001 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRHTU1t>; Mon, 20 Aug 2001 16:27:49 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:2570 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S269158AbRHTU1m>;
	Mon, 20 Aug 2001 16:27:42 -0400
Message-Id: <200108202027.f7KKRnY41946@aslan.scsiguy.com>
To: Cliff Albert <cliff@oisec.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo 
In-Reply-To: Your message of "Mon, 20 Aug 2001 10:55:20 +0200."
             <20010820105520.A22087@oisec.net> 
Date: Mon, 20 Aug 2001 14:27:49 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
>the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
>i've been getting these errors since 2.4.3.
>
>> booting with append="noapic", gives the same errors

Can you send me the full messages when you boot with "aic7xxx=verbose"?
That should help indicate the source of your problems.  I also
need to see the devices that are attached to the bus, so a full dmesg
from a successful boot with the old driver would be helpful.

--
Justin
