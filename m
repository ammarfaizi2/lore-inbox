Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131506AbRCWXQg>; Fri, 23 Mar 2001 18:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRCWXQR>; Fri, 23 Mar 2001 18:16:17 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8082 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131506AbRCWXP7>;
	Fri, 23 Mar 2001 18:15:59 -0500
Date: Sat, 24 Mar 2001 00:15:15 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103232315.AAA07966.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[to various people]

No, ulimit does not work. (But it helps a little.)
No, /proc/sys/vm/overcommit_memory does not work.

[to Alan]

> Nobody feels its very important because nobody has implemented it.

Yes, that is the right response.
What can one say? One can only do.

Andries

