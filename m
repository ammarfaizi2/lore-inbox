Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275437AbTHIXz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275438AbTHIXz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:55:26 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43978 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S275437AbTHIXzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:55:24 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
Date: Sun, 10 Aug 2003 00:58:16 +0100
User-Agent: KMail/1.5.3
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308100058.16261.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 18:47, Mike Galbraith wrote:
> 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.

What do you mean by "disturb"?

Regards,

Daniel

