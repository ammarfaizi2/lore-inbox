Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUHDTXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUHDTXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUHDTXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:23:44 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:12187 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S267387AbUHDTXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:23:42 -0400
From: Remon Sijrier <remon@vt.shuis.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
Date: Wed, 4 Aug 2004 21:24:36 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408042124.36537.remon@vt.shuis.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The compilation went fine, but there are some problems I can't solve :-(

I had to disable both drm (dri) and acpi to get rid from warning messages but 
still X doesn't start with the following message in it's log file:

xf86OpenSerial cannot open device /dev/psaux no such device

This wasn't a problem before. Any help would be appreciated.

Thanks,

Remon

P.S. 
Please CC me, I'm not on the list
