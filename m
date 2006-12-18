Return-Path: <linux-kernel-owner+w=401wt.eu-S1753813AbWLRLCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbWLRLCQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbWLRLCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:02:16 -0500
Received: from smtp.trashmail.net ([213.41.184.212]:35207 "EHLO
	smtp.trashmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbWLRLCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:02:15 -0500
X-Greylist: delayed 1999 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 06:02:15 EST
To: linux-kernel@vger.kernel.org
From: rrcwjpgr <rrcwjpgr@trashmail.net>
Subject: 2.4.28: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) ?
Message-Id: <20061218103243.97FF9BB1A02B7@smtp.trashmail.net>
Date: Mon, 18 Dec 2006 11:32:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first thanks for your great support on the Linux kernel.
I have a problem with kernel 2.4.28 and maybe somebody has an idea about my problem. When I type dmesg, I get this error messages:
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process python

For any kind of reason a python script is killed.
What this kind of error message means?
Is this the memory killer? This would mean that maybe I have a memory leak in the python script?


Best regards,
saf
-- 
E-Mail sent with anti-spam site TrashMail.net!
Free disposable email addresses: http://www.trashmail.net/
