Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTENT2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTENT2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:28:08 -0400
Received: from mail.webmaster.com ([216.152.64.131]:43985 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261159AbTENT2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:28:07 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Dave Jones" <davej@codemonkey.org.uk>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: What exactly does "supports Linux" mean?
Date: Wed, 14 May 2003 12:40:51 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEKCCPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030514144443.GA7203@suse.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, May 14, 2003 at 02:09:33PM +0000, Henning P. Schmiedehausen wrote:

>  > >From a user land perspective, only major Linux vendors or
>  > organizations could enforce such a logo program, it would cost wads of
>  > cash and it will really suck if you currently run the certification
>  > process for Linux 2.5.102 for your driver and right before you're
>  > done, 2.5.103 is released and you have to start all over again.

> Certifying anything against a development series kernel is completely
> pointless.  Breakage outside the driver itself could have adverse
> affects. Example: For the last dozen or so kernels, the i845 AGP driver
> crashed on exiting X. Turned out to be a VM bug.

	This is why I think it only makes sense to certify a product that either
provides a source code driver or sufficient documentation to allow someone
to write one. Even if the driver is bugfree, you still have to be able to
debug around it.

	DS


