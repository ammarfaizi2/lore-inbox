Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVHAV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVHAV41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVHAVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:54:12 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:1674 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261307AbVHAVxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:53:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: that sk98lin suspend/resume patch
Date: Mon, 1 Aug 2005 23:58:33 +0200
User-Agent: KMail/1.8.1
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1122853152.7483.0.camel@localhost>
In-Reply-To: <1122853152.7483.0.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508012358.33504.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 1 of August 2005 01:39, Kasper Sandberg wrote:
> hello, i run 2.6.13-rc4-git2, and i am experiencing problems with
> sk98lin, suddenly it just stops working, and i need to reboot to get
> network up again, does this fix it?

Unfortunately, it doesn't.  It is only relevant if you suspend/resume your box.
You can try the skge driver however.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
