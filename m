Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUAINdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 08:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUAINdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 08:33:09 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:28156 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261681AbUAINdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 08:33:07 -0500
From: Moritz Moeller-Herrmann <mmh@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: RE: psmouse synchronization loss under load
Date: Fri, 9 Jan 2004 14:30:56 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401091430.57552.mmh@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem in 2.6.1: Infrequently the mouse(rather: the 
trackpoint) jumps around and clicks wildly on the desktop.... Extremely 
annoying. The log message is identical. I do not think it is dependent on 
load. It only happens when I USE the pointer though...

I am using Debian/unstable, X-4.3, linux-2.6.1 with alsa and the DSDT-initrd 
patch on my IBM Thinkpad R31 Mobile Celeron 1,2 GHz. 

Bye, Moritz Moeller-Herrmann
