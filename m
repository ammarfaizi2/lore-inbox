Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbTAKLzr>; Sat, 11 Jan 2003 06:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267195AbTAKLzr>; Sat, 11 Jan 2003 06:55:47 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:6668 "EHLO sawmill")
	by vger.kernel.org with ESMTP id <S267194AbTAKLzr>;
	Sat, 11 Jan 2003 06:55:47 -0500
Date: Sat, 11 Jan 2003 13:04:32 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (revised) fix net/irda warnings for 2.4.21-pre3
Message-ID: <20030111120432.GA28023@sawmill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Tony <kernel@mail.vroon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch download location:
http://www.chainsaw.cistron.nl/compile-fixes-irda.patch.gz

The patch I announced several hours ago had issues. I have replaced the 
file on the website with a correct version. If anyone had already 
downloaded the fix, please do so again.
This fixes the numerous "Concatenation of string literals with 
__FUNCTION__ is depricated" errors in net/irda. This should apply 
cleanly to both a 2.4.21-pre3 and a 2.4.21-pre3-ac3 tree.

GCC 3+ users, please inform me if this patch works for you, so it can be 
submitted.

Thanks,
Tony Vroon.
