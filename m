Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269012AbRHBQDA>; Thu, 2 Aug 2001 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269014AbRHBQCu>; Thu, 2 Aug 2001 12:02:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:53646 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269012AbRHBQCe>;
	Thu, 2 Aug 2001 12:02:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 16:02:38 GMT
Message-Id: <200108021602.QAA113498@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: brent@linux1.org, garloff@suse.de, linux-kernel@vger.kernel.org,
        mantel@suse.de, rubini@vision.unipv.it, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>:

> 2.2 has had the sysctl for ages, and it defaults to off

Not precisely - it is a boot parameter "psaux-reconnect".
That is better than a sysctl.
