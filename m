Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULMSAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULMSAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 13:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULMSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 13:00:06 -0500
Received: from hera.kernel.org ([209.128.68.125]:61643 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261300AbULMSAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:00:01 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: sk98lin patch 7.09 hiccups on 2.6.10-rc3
Date: Mon, 13 Dec 2004 09:59:00 -0800
Organization: Open Source Development Lab
Message-ID: <20041213095900.1c10209d@dxpl.pdx.osdl.net>
References: <41BBCDD9.5080603@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1102960740 11334 172.20.1.103 (13 Dec 2004 17:59:00 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 13 Dec 2004 17:59:00 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your expectation is faulty. An out of tree vendor patch needs
to be kept up to date with the evolving kernel, not the other
way around.

Also, the only major improvement in the vendor patch is support for
the Yukon2 hardware, but the code is so macroized that it will
never be accepted in it's current form.
