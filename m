Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEZSil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEZSil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVEZSik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:38:40 -0400
Received: from mail.cybermesa.com ([198.59.109.2]:40091 "EHLO
	mail.cybermesa.com") by vger.kernel.org with ESMTP id S261692AbVEZSi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:38:29 -0400
Subject: KSTK_ESP macro in linux/arch/x86_64/processor.h
From: Valerio Aimale <vga@seirad.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SeiraD, Inc.
Date: Thu, 26 May 2005 12:38:23 -0600
Message-Id: <1117132703.8973.12.camel@titus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd just like to have the coordinates of the maintainer of
linux/arch/x86_64/processor.h

I'd have a need to sneak up on the stack pointer of various process on a
amd64 architecture and  the KSTK_ESP macro for x86_64 still returns -1

Please CC: me in replies as I don't actively subscribe to the list.

Thanks,

Valerio

-- 
Valerio Aimale
Scientist
SeiraD, Inc.
3900 Paseo del Sol
Santa Fe, NM, 87507


