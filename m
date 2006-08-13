Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWHMTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWHMTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWHMTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:47:09 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:28296 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751386AbWHMTrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:47:08 -0400
Message-ID: <44DF81D2.8010807@drzeus.cx>
Date: Sun, 13 Aug 2006 21:47:30 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Shaohua Li <shaohua.li@intel.com>
Subject: Problem reaching Intel's mail servers
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I've been having trouble sending any mail to intel, and as there's a bit
of catch-22 trying to inform them of this, I'll send a mail here and
hope you'll see it.

All my mail sent to you fail because of a timeout connecting to your
server. The problem seems to be mga11.intel.com, which happens to be the
first choice when my outgoing mail server has finished sorting. As to
why my MTA doesn't move on to the next one, I do not know. But having a
MX entry to a machine that drops everything probably isn't a good idea
in the long run anyway...

Rgds
Pierre
