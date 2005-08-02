Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVHBLWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVHBLWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVHBLWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:22:25 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:51358 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261505AbVHBLWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:22:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc4-mm1: Hard hang under load on AMD64
Date: Tue, 2 Aug 2005 13:27:27 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021327.28651.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Athlon64-based notebook (64-bit environment) has just hanged solid under
load on 2.6.13-rc4-mm1.  The same happend (on 2.6.13-rc4-mm1) some time ago
to a dual-Opteron box I have access to.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
