Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbUACKUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 05:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUACKUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 05:20:19 -0500
Received: from main.gmane.org ([80.91.224.249]:50374 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263053AbUACKUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 05:20:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Michael Stucki <mundaun@gmx.ch>
Subject: Re: Unable to handle kernel NULL pointer dereference
Date: Sat, 03 Jan 2004 10:47:05 +0100
Message-ID: <bt632p$26h$1@sea.gmane.org>
References: <200401011944.51109.lilo.please.no.spam@roccatello.it> <20040102013238.GC19598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

I have exactly the same problem and I am using nvidia's binary drivers as
well, so they might be a problem anyway.

> There is a patch in the -mm tree to fix this.  I've included it here
> below.

Thanks. Unfortunately, this doesn't solve my problem.

Maybe this information could be useful:
http://www.mstucki.net/files/misc/messages.txt

Kind regards
- michael

