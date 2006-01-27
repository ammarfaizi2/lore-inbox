Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWA0CQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWA0CQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWA0CQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:16:35 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:49933 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030214AbWA0CQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:16:34 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: GPL V3 and Linux - Dead Copyright Holders
Date: Thu, 26 Jan 2006 18:15:54 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEBHJLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D8FEF2.3080502@wolfmountaingroup.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 18:12:52 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 26 Jan 2006 18:12:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus is posturing. I can go back to numerous previous versions when he
> and stallman were "buddy buddy" and the language was open
> and said "any later version". Well, here's the gotcha. Any version
> released before Linus said this is GPL 2, 3 or later. As of today, all new
> versions are GPLv2. That's how the law works. So 2.6.15 forward is GPLv2
> only. Linus cannot re-release previous Linux versions after he
> already posted this NOTICE in COPYING, which he did and left the
> language pen like this. So it's up to the recevier of the code whether
> its GPLv2 or GPLv3 or whatever, but those releases which appeared with
> COPYING stating this language are whatever GPL license you
> want.
>
> Jeff

	Linus can't put additional restrictions on code he didn't write. If the
authors licensed it under the GPL version 2 and "any later version", Linus
can't re-release it under a more restrictive license. Read section 6
carefully:

  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

	Notice that the code is licensed to you by the "original licensor", not by
the distributor. The inability to choose a later GPL version is definitely a
"further restriction".

	At least, that's how I read it.

	DS


