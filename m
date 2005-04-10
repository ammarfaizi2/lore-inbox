Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDJDV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDJDV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVDJDV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 23:21:59 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:62102 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S261294AbVDJDV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 23:21:58 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Sun, 10 Apr 2005 04:19:04 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <20050409194746.69cfa230.akpm@osdl.org>
In-Reply-To: <20050409194746.69cfa230.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504100419.04849.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 10 April 2005 03:47, Andrew Morton wrote:
>
> Suggest you boot with `nmi_watchdog=0' to prevent the nmi watchdog from
> cutting in during long sysrq traces.
>
> Also, capture the `sysrq-m' output so we can see if the thing is out of
> memory.

  OK, will do it ASAP and report back.

 Thanks,

Claudio

