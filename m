Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWI2CbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWI2CbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWI2CbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:31:06 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:19722 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1161276AbWI2CbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:31:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPLv3 Position Statement
Date: Thu, 28 Sep 2006 19:29:55 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCENGOLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060928144028.GA21814@wohnheim.fh-wedel.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 28 Sep 2006 19:32:58 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 28 Sep 2006 19:32:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In my very uninformed opinion, your problem is a very minor one.  Your
> "v2 or later" code won't get the license v2 removed, it will become
> dual "v2 or v3" licensed.  And assuming that v3 only adds restrictions
> and doesn't allow the licensee any additional rights, you, as the
> author, shouldn't have to worry much.
>
> The problem arises later.  As with BSD/GPL dual licensed code, where
> anyone can take the code and relicense it as either BSD or GPL, "v2 or
> v3" code can get relicensed as v3 only.  At this point, nothing is
> lost, as the identical "v2 or v3" code still exists.  But with further
> development on the "v3 only" branch, you have a fork.  And one that
> doesn't just require technical means to get merged back, but has legal
> restrictions.

Unless I'm missing something, you *cannot* change the license from "v2 or
later at your option" to "v3 or later". Both GPLv2 and GPLv3 explicitly
prohibit modifying license notices. (Did the FSF goof big time? It's not too
late to change the draft.)

DS


