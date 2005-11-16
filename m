Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbVKPUjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVKPUjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbVKPUjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:39:45 -0500
Received: from [212.76.86.10] ([212.76.86.10]:15887 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030494AbVKPUjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:39:44 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: MPP aware CPUSETS
Date: Wed, 16 Nov 2005 23:37:23 +0300
User-Agent: KMail/1.5
Cc: linux-smp@vger.kernel.org, pj@sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511162337.23722.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CPUSETS are a neat way to manage Task-to-CPU affinity.

But CPUSETS are system local.

Would extending CPUSETS to make it MPP aware be a reasonable feature?

--
Al

