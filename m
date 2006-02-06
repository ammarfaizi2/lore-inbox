Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWBFHBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWBFHBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWBFHBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:01:49 -0500
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165]:18366 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751048AbWBFHBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:01:48 -0500
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Andrew Morton'" <akpm@osdl.org>, "'Richard Purdie'" <rpurdie@rpsys.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx devices]
Date: Sun, 5 Feb 2006 23:01:43 -0800
Message-ID: <002a01c62aeb$30c55e00$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20060205192025.4006a554.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton [mailto:akpm@osdl.org]
>MIT license is unusual.  There's one other file in the kernel which uses it
>and that's down in MTD where nobody dares look.

Well, I look at the MTD code a lot... That's why I used it (i.e. that was the
existence proof I found that it's fine ;-)

>I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.

Nothing it that license precludes the code being redistributed under the
GPL.  (It is a verbatim copy of
http://www.opensource.org/licenses/mit-license.php).

>MODULE_LICENSE("Dual MIT/GPL");

Is fine with me, indeed, given the license text, I don't believe I retain
any rights to *prevent* such a change (and it was certainly not my intent
to prevent redistribution under a more restrictive license).  Using 'MIT'
or substituting some more specific tag must be fine for the same reason
(it's a name of a license, not a license itself).

John Bowler <jbowler@acm.org>

