Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTJTH3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJTHYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:24:03 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:50180 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S262418AbTJTHWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:34 -0400
From: Meelis Roos <mroos@linux.ee>
To: kraken@drunkmonkey.org, linux-kernel@vger.kernel.org
Subject: Re: Network module (de4x5) wont load
In-Reply-To: <20031018224240.GA11644@wang-fu.org>
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.6.0-test7 (i686))
Message-Id: <E1ABUN0-0002E3-EQ@rhn.tartu-labor>
Date: Mon, 20 Oct 2003 10:22:26 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NP> This same thing happens on my Alpha (4 x EV45, 512mb RAM).  The system
NP> will boot fine so long as I never bring up networking... The driver
NP> scans for and finds the devices, but as soon as the system attempts to
NP> bring up an interface, it locks up.

Same here on PPC - either tulip or de4x5 driver, the onboard 21140 hangs
on ifconfiog on my Motorola Powerstack.

-- 
Meelis Roos
