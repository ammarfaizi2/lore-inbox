Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266585AbSKUMGK>; Thu, 21 Nov 2002 07:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbSKUMGK>; Thu, 21 Nov 2002 07:06:10 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:54413 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266585AbSKUMGK>; Thu, 21 Nov 2002 07:06:10 -0500
Message-Id: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 21 Nov 2002 13:13:12 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: L1_CACHE_SHIFT value for P4 ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What should be the value of L1_CACHE_SHIFT for a P4 ?
L1_CACHE_BYTES is set to 1<<L1_CACHE_SHIFT

In the .config , I notice that L1_CACHE_SHIFT is being set to 7 for the P4.
Surely that can't be right or ?

