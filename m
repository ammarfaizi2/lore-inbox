Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272190AbRHXPvD>; Fri, 24 Aug 2001 11:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272201AbRHXPum>; Fri, 24 Aug 2001 11:50:42 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:35279 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S272189AbRHXPuj>; Fri, 24 Aug 2001 11:50:39 -0400
Message-ID: <3B86771E.3050207@AnteFacto.com>
Date: Fri, 24 Aug 2001 16:47:42 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] CPU temperature control
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a C3 700MHz CPU underclocked to 466MHz (66MHz FSB),
and @ full load I'm getting the CPU to 63°C in a fanless 1U case.
What I would like is to throttle the CPU back X% if the temperature
exceeds say 50% which I can easily read using lm sensors.
So, what's the best way to do this? user space / kernel space??
Note the C3 has a suspend on halt (instruction) option which will
help things also.

cheers,
Padraig.

