Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbUKEAAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUKEAAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUKDX7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:59:23 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:530 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262514AbUKDX6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:58:08 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Possible GPL infringement in Broadcom-based routers
Date: Thu, 4 Nov 2004 15:57:33 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCENFPIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <418ABC5F.6060200@enix.org>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 04 Nov 2004 15:34:05 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 04 Nov 2004 15:34:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can Broadcom and the vendors "escape" the obligations of the GPL by
> shipping those proprietary drivers as modules, or are they violating the
> GPL plain and simple by removing the related source code (and showing
> irrelevant code to show "proof of good will") ?

	That is a contentious issue that has been debated on this group far too
much. In the United States, at least, the answer comes down to the complex
legal question of whether the module is a "derived work" of the Linux kernel
and whether the kernel as shipped with those modules is a "mere
aggregation".

	You can google those terms to form your own opinions. IMO, discussing and
debating these type of borderline GPL violations on the LKML is not a good
idea. Save bringing up GPL violations on the LKML for cases where the
violation is really obvious and all measures short of public shaming have
already been tried.

	DS


