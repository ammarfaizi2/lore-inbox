Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUH3I1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUH3I1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUH3I1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:27:01 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:50391 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S267382AbUH3I07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:26:59 -0400
X-SMType: Regular
X-SMRef: N1-07aZc-bx
Message-ID: <4132E4EB.4020909@safe-mail.net>
Date: Mon, 30 Aug 2004 16:27:23 +0800
From: Liu Tao <liutao@safe-mail.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: function/varible naming rules?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Many kernel functions/variables start with "_" or "__", are there some 
common
naming rules for them? How to select the name between foo, _foo and __foo?

--
Best Regards,
Liu Tao
