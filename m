Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVHBPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVHBPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVHBPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:17:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:194 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261510AbVHBPRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:17:04 -0400
Date: Tue, 2 Aug 2005 17:17:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Idle after panic
Message-ID: <Pine.LNX.4.61.0508021715050.4634@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


currently, the linux kernel does an endless for(;;) loop when a panic has 
occurred. Could not it be changed so that it does some idling `a la HLT 
instruction again?


Jan Engelhardt
-- 
