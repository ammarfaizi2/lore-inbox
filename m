Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUGRN1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUGRN1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 09:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUGRN1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 09:27:39 -0400
Received: from [202.76.92.172] ([202.76.92.172]:25348 "EHLO main.coppice.org")
	by vger.kernel.org with ESMTP id S264012AbUGRN1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 09:27:38 -0400
Message-ID: <40FA7A83.60800@coppice.org>
Date: Sun, 18 Jul 2004 21:26:27 +0800
From: Steve Underwood <steveu@coppice.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8 rc2 still has keyboard trouble
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It seems widely reported that recent versions of Linux do not work 
properly with non-USB keyboards and mice when built for SMP. I just 
tried 2.6.8rc2, and the problem is still there. The workaround many 
people have is to turn off USB legacy support in their BIOS. On my Tyan 
2665 motherboard there is no BIOS option to do this. If I turn off USB 
support completely in the BIOS my machine runs OK, but then...... well, 
I want USB working :-) With a non-SMP kernel I do not have any problems.

Is this problem being actively addressed by anyone, or is the "turn off 
legacy support" workaround considered an adequate fix?

Regards,
Steve

