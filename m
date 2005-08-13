Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVHMMsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVHMMsY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 08:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVHMMsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 08:48:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27562 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932161AbVHMMsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 08:48:23 -0400
Date: Sat, 13 Aug 2005 14:48:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Redirect kernel console
Message-ID: <Pine.LNX.4.61.0508131447220.4457@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


there is a klogconsole utiltity that allows to change the console to which 
kernel messages are printed. However, is it possible to redirect to ttyS0 
without a reboot?


Jan Engelhardt
-- 
