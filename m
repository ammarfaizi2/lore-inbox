Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUEaFU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUEaFU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 01:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUEaFU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 01:20:59 -0400
Received: from mail.gurulabs.com ([66.62.77.7]:18583 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S264537AbUEaFU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 01:20:58 -0400
Subject: Re: Why is proper NTFS-driver difficult?
From: Dax Kelson <dax@gurulabs.com>
To: Martin Olsson <mnemo@minimum.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40BA1FD5.9080902@minimum.se>
References: <40BA1FD5.9080902@minimum.se>
Content-Type: text/plain
Message-Id: <1085980819.12504.3.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 (1.5.7-2) 
Date: Sun, 30 May 2004 23:20:20 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-30 at 19:54 +0200, Martin Olsson wrote:
> Hello,
> 
> 
> I was wondering why is there no Linux NTFS-driver which allows full 
> writing etc? Is there something that makes this particular difficult to 
> implement? I mean Linux supports so many file systems, why has proper 
> NTFS support been neglected?
> 
> Is there any file system I can use which satisfies these criteria:
> A) works in both Linux and Windows
> B) handle >4GB files
> C) handle 120GB partitions

UDF meets A & B. I don't if it meets C.

Dax

