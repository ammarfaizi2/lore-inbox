Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUKHVFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUKHVFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKHU7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:59:32 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:22533 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261225AbUKHUxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:53:48 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <pjvenda@rnl.ist.utl.pt>, <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox + code
Date: Mon, 8 Nov 2004 12:53:22 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGECMPKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <418F890D.5070404@rnl.ist.utl.pt>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 08 Nov 2004 12:29:50 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 08 Nov 2004 12:29:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> if that's the case, isn't it necessary to distribute the proprietary
> parts separately (or vice-versa)? else those proprietary parts would
> also be under the GPL.

	It depends what you mean by speparately. RedHat ships CDs that contain both
GPL'd and non-GPL'd packages. They're even tweaked to work together. It
comes down to whether the the thing they're shipping is a single work or a
collection of works, and to what extent you can draw the line between them.
I don't know enough about sveasoft's packaging to say.

	However, one thing is clear. If they actually modify source files that
started out as GPL'd works, and then ship the executables, they are
definitely shipping a single work that is a derivative of the GPL'd work.

	DS


