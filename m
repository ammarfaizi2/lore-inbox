Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTKYLsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 06:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKYLsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 06:48:31 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13713 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262375AbTKYLsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 06:48:30 -0500
Date: Tue, 25 Nov 2003 09:42:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-rc5
Message-ID: <Pine.LNX.4.44.0311250940190.1451-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 

Yet another thing showed up (possible data corruption on x86-64), so here 
goes -rc5.


Summary of changes from v2.4.23-rc4 to v2.4.23-rc5
============================================

Andi Kleen:
  o Fix 32bit truncate64 on x86-64

Marcelo Tosatti:
  o Felix Radensky: Remove debugging printk from agpgart
  o Changed EXTRAVERSION to -rc5



