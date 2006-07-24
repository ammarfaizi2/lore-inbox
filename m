Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWGXWnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWGXWnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWGXWnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:43:07 -0400
Received: from imo-m19.mx.aol.com ([64.12.137.11]:18325 "EHLO
	imo-m19.mx.aol.com") by vger.kernel.org with ESMTP id S932309AbWGXWnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:43:06 -0400
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 18:43:00 -0400
From: daveflinux@aim.com
Message-Id: <8C87D89A6C9AC58-1FD4-1F71@mblk-d16.sysops.aol.com>
X-MB-Message-Source: WebUI
X-MB-Message-Type: User
X-Mailer: AIM WebMail 18735
Subject: What is the difference between sk_wmem_queued & sk_wmem_alloc ?
Content-Type: text/plain; charset="us-ascii"; format=flowed
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-AOL-IP: 205.188.149.8
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 In the sock structure (include/net/sock.h),
 can anybody tell me the difference between
 sk_wmem_queued (persistent transmit queue size)
 & sk_wmem_alloc (transmit queue bytes commited).
 Both appear to serve the same function.

 thanks
 Dave
________________________________________________________________________
Check Out the new free AIM(R) Mail -- 2 GB of storage and 
industry-leading spam and email virus protection.

