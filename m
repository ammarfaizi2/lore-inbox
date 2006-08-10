Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHJVnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHJVnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHJVnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:43:35 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:32741 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751134AbWHJVne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:43:34 -0400
Date: Thu, 10 Aug 2006 23:43:22 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Eric Anholt <eric@anholt.net>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org,
       Alan Hourihane <alanh@tungstengraphics.com>
Subject: Re: [PATCH] Add support for Intel i965G/Q GARTs.
Message-ID: <20060810214322.GA16105@mail.muni.cz>
References: <11551502672606-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11551502672606-git-send-email-eric@anholt.net>
User-Agent: Mutt/1.4.1i
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

tried patch on P965 chipset containing 8086:29a0 memory controller.
I got in dmesg:
agpgart: Detected an Intel 965G Chipset.
agpgart: AGP aperture is 256M @ 0x0

is this supposed to be correct?

This warning can be related (0000:01:00.0 is Nvidia NX7600GS graphic).
PCI: Failed to allocate mem resource #6:20000@30000000 for 0000:01:00.0

-- 
Luká¹ Hejtmánek
