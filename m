Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTJTOHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTJTOHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:07:03 -0400
Received: from mail.g-housing.de ([62.75.136.201]:60388 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262570AbTJTOHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:07:01 -0400
Message-ID: <3F93EC03.8000406@g-house.de>
Date: Mon, 20 Oct 2003 16:06:59 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: de-de, de, en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Network module (de4x5) wont load
References: <E1ABUN0-0002E3-EQ@rhn.tartu-labor>
In-Reply-To: <E1ABUN0-0002E3-EQ@rhn.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos schrieb:
> NP> This same thing happens on my Alpha (4 x EV45, 512mb RAM).  The system
> NP> will boot fine so long as I never bring up networking... The driver
> NP> scans for and finds the devices, but as soon as the system attempts to
> NP> bring up an interface, it locks up.
> 
> Same here on PPC - either tulip or de4x5 driver, the onboard 21140 hangs
> on ifconfiog on my Motorola Powerstack.
> 

for the record:

and same here for the 3c59x driver (and the onboard 21140 (tulip)). the 
machine freezes upon loading/unloading the network drivers.
(ppc32, Mototola Powerstack).

Christian.
-- 
BOFH excuse #126:

it has Intel Inside

