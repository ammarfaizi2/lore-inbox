Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVCXKuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVCXKuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVCXKuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:50:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20426 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262772AbVCXKuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:50:00 -0500
Date: Thu, 24 Mar 2005 11:49:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: swapper process
Message-ID: <Pine.LNX.4.61.0503241148220.27454@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


when stuffing a minimalistic environment into initrd (bash,libc and ps) into 
an initrd, and I run ps from within, I get "[swapper]" with PID 1 and linuxrc 
as PID 123 (think one up). What's the swapper doing?
As booting with root=/dev/ram0 init=/linuxrc puts linuxrc in pid 1.


Jan Engelhardt
-- 
