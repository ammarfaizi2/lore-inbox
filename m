Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUIWUzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUIWUzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUIWUzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:55:39 -0400
Received: from [217.79.151.115] ([217.79.151.115]:32960 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S267358AbUIWUyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:54:05 -0400
Date: Thu, 23 Sep 2004 22:54:01 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: Not loading DOS parition driver for selected disk?
Message-ID: <Pine.LNX.4.60.0409232249220.20974@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any way to tell the kernel that I do not want to make partition 
(/dev/sda1, /dev/sda2, ...) devices (but I still want to have /dev/sda and 
/dev/sdb and /dev/sdb1, /dev/sdb2, ...)?

This can be useful for people that want to use evms/dm for partition 
management instead of kernel directly on selected disks.


Thanks in advance,

Grzegorz Kulewski

