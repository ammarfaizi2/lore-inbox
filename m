Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUBCDYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUBCDYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:24:36 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:5644 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265764AbUBCDYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:24:34 -0500
Message-ID: <1075779801.401f18d990ac8@vds.kolivas.org>
Date: Tue,  3 Feb 2004 14:43:21 +1100
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-ck3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First public 2.6 -ck patchset

Download, descriptions, split out patches available here:
http://kernel.kolivas.org

Summary:
O21int
This is a very small fix for the interactivity estimator. It will be included in
2.6.2 mainline.

am6
Autoregulates the virtual memory swappiness.

batch7
Batch scheduling.

iso1
Isochronous scheduling.

htbase1
Base patch for hyperthread modifications

httweak1
Tiny performance enhancements for hyperthreading

htnice2
Make "nice" hyperthread smart

htbatch1
Make batch scheduling hyperthread smart

cfqioprio
Complete Fair Queueing disk scheduler and I/O priorities

schedioprio
Set initial I/O priorities according to cpu scheduling policy and nice.


Con
