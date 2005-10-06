Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVJFFjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJFFjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 01:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVJFFjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 01:39:51 -0400
Received: from [213.132.87.177] ([213.132.87.177]:20289 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S1751233AbVJFFju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 01:39:50 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Question]: system register cr3
Date: Thu, 6 Oct 2005 09:41:25 +0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510060941.25535.dr_unique@ymg.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 05:46:16.0012 (UTC) FILETIME=[4470D8C0:01C5CA39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> I change value of cr3 register.
> After that TLB cache flushed. Does it also flush instruction cache in processor?

Arch is i386.

-- 
RomanU
