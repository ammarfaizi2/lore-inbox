Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbVKBVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbVKBVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbVKBVG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:06:57 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:13236 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S965239AbVKBVG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:06:56 -0500
From: tcrix@att.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: No sharing IRQ broken board problem
Date: Wed, 02 Nov 2005 21:06:53 +0000
Message-Id: <110220052106.23704.43692A6C000AA6AE00005C98215876675598079D0C9B@att.net>
X-Mailer: AT&T Message Center Version 1 (Oct 30 2005)
X-Authenticated-Sender: dGNyaXhAYXR0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pci board in development that works but..
it can not share the interrupt line.  

Has someone hacked through the problem of reserving one of the inta, intb, .. 's for a single device?  I would love to see how you did so I could continue on with my driver while I wait for the !@$#!@ hardware guys to fix the board. 

Thanks for the help,
Tom Rix




