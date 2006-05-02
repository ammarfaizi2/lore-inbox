Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWEBT1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWEBT1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEBT1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:27:18 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51600 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750864AbWEBT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:27:18 -0400
Date: Tue, 2 May 2006 15:27:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Question about cmpxchg()
Message-ID: <Pine.LNX.4.44L0.0605021524530.1170-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to know at build time (or even at runtime) whether the 
cmpxchg() routine is atomic with respect to DMA transfers on the current 
platform?

Thanks,

Alan Stern

