Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSANTmY>; Mon, 14 Jan 2002 14:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288926AbSANTlG>; Mon, 14 Jan 2002 14:41:06 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:58752 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S288921AbSANTkP>; Mon, 14 Jan 2002 14:40:15 -0500
Date: Mon, 14 Jan 2002 14:40:14 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200201141940.g0EJeEF11319@jik.kamens.brookline.ma.us>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre3-ac2 appears to solve my IDE problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Readers of this list may recall my previous postings about problems
I've been having with UDMA in 2.4.x.  E.g., see starting at
<http://groups.google.com/groups?hl=en&frame=right&th=5431687b5f68da06&seekm=fa.kpi9bmv.1c3al9f%40ifi.uio.no#link1>
or just search for "Kamens" in the lkml archives.

FYI, Alan Cox recently suggested that I try 2.4.18-pre3-ac2 to see if
it does any better, and indeed so far with that kernel I haven't
experienced any of the problems I reported previously.

  jik
