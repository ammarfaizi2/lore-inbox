Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSJAPga>; Tue, 1 Oct 2002 11:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJAPga>; Tue, 1 Oct 2002 11:36:30 -0400
Received: from host194.steeleye.com ([66.206.164.34]:43012 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261724AbSJAPg3>; Tue, 1 Oct 2002 11:36:29 -0400
Message-Id: <200210011541.g91FfqW04093@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH VOYAGER] new subarchitecture for 2.5.40
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Oct 2002 11:41:52 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP (and UP) support for voyager which is an (up to 32 way) 
SMP microchannel non-PC architecture.

This current patch includes a fix for the 4100 which allows it to boot up 
correctly with dual VIC lines into its quad cards.

The patch (154k) is available here:


http://www.hansenpartnership.com/voyager/files/voyager-2.5.40.diff

And also via bitkeeper at

http://linux-voyager.bkbits.net/voyager-2.5

James Bottomley


