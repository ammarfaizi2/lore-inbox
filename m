Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUJFTuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUJFTuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUJFTuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:50:54 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:46783 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S269415AbUJFTuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:50:37 -0400
Subject: linux 2.6.9-rc3: ub oops on device removal
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Oct 2004 21:50:06 +0200
Message-Id: <1097092206.6663.26.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I get this oops on kernel 2.6.9-rc3 on a 15" powerbook.

xmon trace screenshot is at:
http://fortknox.dyndns.org/pics/oopses/ub.jpg

Any ideas ?

Soeren
-- 
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety." Benjamin Franklin

