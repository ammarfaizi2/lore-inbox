Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTGXSdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269700AbTGXSdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:33:13 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19072 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S269676AbTGXSdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:33:12 -0400
Date: Thu, 24 Jul 2003 19:57:32 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307241857.h6OIvWEd000651@81-2-122-30.bradfords.org.uk>
To: elenstev@mesatop.com, Robert.L.Harris@rdlg.net
Subject: Re: Posting format
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org, szepe@pinerecords.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At home, I'm on a 56k dialup, and getting the days worth of lkml
> messages takes a while.

If you're collecting mail via POP, try switching to a protocol like a
streamed SMTP push, if your ISP supports it - collecting a lot of
small mails, which is usually what this list is, using POP generally
won't use anywhere near the full capacity of the link, because there
is so much protocol overhead.  Over a satellite link, it's even worse,
because of the high latency.

> Cutting down on unnecessary verbage which can easily be retrieved if
> needed is definitely appreciated.

Can we all, please, at least do things like not repeatedly quoting the
list's four-line signature, and not quoting things like .config files?
There surely can't be any disagreements about that :-).

John.
