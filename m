Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUHLV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUHLV6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUHLV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:58:39 -0400
Received: from smtpout3.compass.net.nz ([203.97.97.135]:57771 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S268827AbUHLV5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:57:36 -0400
Date: Fri, 13 Aug 2004 09:58:40 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Problem report. USB flash disk problem with 2.6.7
Message-ID: <Pine.LNX.4.53.0408130955440.519@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am sorry if this problem has been known. I got a flash disk. Kernel 2.6.7
can not know if the disk is in the lock mode so it still assumes that
write is enable and of course when write to disk it causes file system panic
and nothing written.

In 2.4.27 if my disk is locked, it is automatically detected and mount it as read-only
and this is an expected behavior.

Thank you very much for your time.


Steve Kieu
