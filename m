Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289001AbSAIUUe>; Wed, 9 Jan 2002 15:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSAIUU3>; Wed, 9 Jan 2002 15:20:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:13463
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289001AbSAIUUT>; Wed, 9 Jan 2002 15:20:19 -0500
Date: Wed, 9 Jan 2002 15:05:24 -0500
Message-Id: <200201092005.g09K5OL28043@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, felix-dietlibc@fefe.de
Subject: initramfs programs (was [RFC] klibc requirements)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg k-h:
>What does everyone else need/want there?

dmidecode, so the init script can dump a DMI report in a known
location such as /var/run/dmi.  

I want this for autoconfiguration purposes.  If I can have it, I
won't need /proc/dmi.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I cannot undertake to lay my finger on that article of the
Constitution which grant[s] a right to Congress of expending, on
objects of benevolence, the money of their constituents.
	-- James Madison, 1794
