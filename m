Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWBTREi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWBTREi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWBTREi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:04:38 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:6314 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1161035AbWBTREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:04:37 -0500
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Alessandro Zummo'" <alessandro.zummo@towertech.it>,
       <linux-kernel@vger.kernel.org>
Cc: "'David Vrabel'" <dvrabel@cantab.net>, "'Adrian Bunk'" <bunk@stusta.de>,
       "'Martin Michlmayr'" <tbm@cyrius.com>, <netdev@vger.kernel.org>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Subject: RE: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values: maclist
Date: Mon, 20 Feb 2006 09:04:28 -0800
Message-ID: <000301c6363f$b6c681a0$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
In-Reply-To: <20060220142258.7299170c@inspiron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My latest version of this patch is here:

http://cvs.sourceforge.net/viewcvs.py/nslu/kernel/2.6.15/91-maclist.patch?rev=1.2&only_with_tag=HEAD&view=markup

In "Recommendations" "With the second strategy" should be "With
the first strategy".

(Note that the '2.6.16' directory in that repo contains an old
version - it is, in fact, rev 1.1 from the 2.6.15 directory.)

John Bowler <jbowler@acm.org>

