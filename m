Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276843AbRJUWOu>; Sun, 21 Oct 2001 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276840AbRJUWOk>; Sun, 21 Oct 2001 18:14:40 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:11437 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276836AbRJUWOc>;
	Sun, 21 Oct 2001 18:14:32 -0400
Posted-Date: Mon, 22 Oct 2001 00:14:57 +0200
Date: Mon, 22 Oct 2001 00:14:56 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: diffserv-general@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] HTB updates
Message-ID: <Pine.LNX.4.10.10110220006540.321-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the HTB is quite tested now so I crossposted notice to LKML too.
The news in HTB qos queuing discipline:

- slots dropped instead new virtual IMQ device will be announced
  in few days
- new dequeue cache to do link sharing beyond 100Mbit
- injection option

Complete manual, examples and patched as usualy at
http://www.cdi.cz/~devik/qos/htb

enjoy. devik

