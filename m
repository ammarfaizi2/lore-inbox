Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUBKMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBKMtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:49:24 -0500
Received: from sea2-f7.sea2.hotmail.com ([207.68.165.7]:12559 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264363AbUBKMtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:49:23 -0500
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: printk and long long 
Date: Wed, 11 Feb 2004 14:49:22 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com>
X-OriginalArrivalTime: 11 Feb 2004 12:49:23.0152 (UTC) FILETIME=[7943BD00:01C3F09D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am trying to perfrom printk with a variable of type long long.
(loff_t is that type and it is long long , as can be seen in posix+types.h).
what is the format string for such a type ?
I had tried %lld" but it gace wrpng results.
regards,
sting

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

