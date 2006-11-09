Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965952AbWKIFXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965952AbWKIFXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbWKIFXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:23:49 -0500
Received: from alnrmhc11.comcast.net ([206.18.177.51]:14525 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1754736AbWKIFXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:23:48 -0500
Message-ID: <4552BB55.9090400@comcast.net>
Date: Wed, 08 Nov 2006 21:23:33 -0800
From: John Wendel <jwendel10@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc5 breaks klogd 1.4.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just installed -rc5, system very slow, noticed klogd in a tight loop 
doing a "read". -rc4 is OK.

Sorry, I have printk configured off, so I don't have any logs.

Thanks,

John

