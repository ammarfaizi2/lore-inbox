Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVJFFjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVJFFjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 01:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJFFjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 01:39:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54422 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751235AbVJFFjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 01:39:05 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [Question]: system register cr3
Date: Thu, 6 Oct 2005 09:37:54 +0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510060937.54765.dr_unique@ymg.ru>
X-OriginalArrivalTime: 06 Oct 2005 05:42:45.0509 (UTC) FILETIME=[C6F8A350:01C5CA38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
I change value of cr3 register.
After that TLB cache flushed. Does it also flush instruction cache in processor?

-- 
RomanU
