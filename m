Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTI2VEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTI2VEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:04:37 -0400
Received: from uni06mr.unity.ncsu.edu ([152.1.1.169]:23685 "EHLO
	uni06mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S262621AbTI2VEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:04:36 -0400
Message-ID: <3F788DE4.8030505@unity.ncsu.edu>
Date: Mon, 29 Sep 2003 15:54:12 -0400
From: Yifan Zhu <yzhu2@unity.ncsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: TIMER_BH in 2.4 kernel
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm looking at the 2.4 kernel. My understanding of the code is that the
TIMER_BH handler is executed when the hardware timer interrupt returns (
after do_IRQ(), but before returning to the interrupted task ). Is that
right?

Thanks for clarification!

Yifan

