Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWHSLpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWHSLpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWHSLpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:45:06 -0400
Received: from main.gmane.org ([80.91.229.2]:5528 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751724AbWHSLpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:45:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Baker <andrew@teledesign.co.uk>
Subject: Re: Daily crashes, incorrect RAID behaviour
Date: Sat, 19 Aug 2006 11:37:15 +0000 (UTC)
Message-ID: <loom.20060819T133036-36@post.gmane.org>
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com> <200608151545.49345@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.252.64.33 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We too are having the same problem and the only obviously common factor is
Maxtor SATA HDD.

We have two identical systems - 64 bit - 2 x Dual Opterons, 8Gb Ram running
Novell/SUSE SLES10. Both systems are showing the problem.

In our case the RAID controller is 

3ware Escalade 9550SX - 8LP

And the HDD are:

Maxtor MaxLine III (7V250F0) 250GB SATA II 

The symptoms here are almost exactly as you describe.  A disc "drops out" once
every week or two and the only way to clear the problem is a power cycle - or
remove and replace the HDD (our system is hot-swap).

Regards

Andrew

