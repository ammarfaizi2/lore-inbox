Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUKHBPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUKHBPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKHBPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 20:15:08 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:30992 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261721AbUKHBOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 20:14:48 -0500
From: "David Schwartz" <davids@webmaster.com>
To: =?iso-8859-1?Q?Rapha=EBl_Rigo_LKML?= <lkml@twilight-hall.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox + code
Date: Sun, 7 Nov 2004 17:14:30 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOENPPJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <200411071438.38516.shawn.starr@rogers.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 07 Nov 2004 16:51:01 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 07 Nov 2004 16:51:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That may have been the past, but if they dont distribute the
> source any more
> they are in violation.
>
> Shawn.

	Hmm, so could I condition distribution of my modified version of the Linux
kernel on signing a contract agreeing to buy a pencil from me for $25,000 if
you ever distribute the source code?

	The GPL says:

  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

	As I read this, any penalty you impose on people for exercising their
rights under the GPL would be a "further restriction".

	For those not familiar, sveasoft revokes your license to receive further
updates if you exercise your distribution rights under the GPL. I would
argue that conditioning the sale of a GPL'd work on a failure to exercise
your rights under the GPL is a "further restriction".

	Any penalty of any kind that you impose on someone for exercising their
rights under the GPL acts to restrict them from exercising those rights. "If
you do X, you lose Y" is a restriction on X.

> Sveasoft has expressed that they think they're in the clear
> because they're shipping the sourcecode to older versions of
> their distribution and their current version is nothing more
> than their old distribution plus some additional proprietary
> code.

	This would be perfectly okay provided the source code to the older version
is identical to the source code in the newer version for all the works based
on works that are GPL'd. So long as you can draw a line between the old code
and the new code, then this is acceptable. However, if there are changes to
GPL'd source code files, then those changes need to be given to anyone who
receives binaries from those source code files. In that case, no line can be
drawn.

	DS


