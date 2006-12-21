Return-Path: <linux-kernel-owner+w=401wt.eu-S1422758AbWLUGcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWLUGcS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWLUGcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:32:18 -0500
Received: from wilanta.cranessoftware.net.in ([59.163.89.36]:2101 "EHLO
	wilanta.cranessoftware.net.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422758AbWLUGcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:32:17 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 01:32:16 EST
From: "vimal.raj" <vimal.raj@cranessoftware.com>
Reply-To: vimal.raj@cranessoftware.com
Organization: cranessoftware
Subject: Fwd: sk buffer to user space
Date: Thu, 21 Dec 2006 11:51:13 +0530
User-Agent: KMail/1.5
To: kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612211151.13750.vimal.raj@cranessoftware.com>
X-MDRemoteIP: 10.0.0.217
X-Return-Path: vimal.raj@cranessoftware.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi kernel experts,

	I'm a newbie to linux kernel.
 I need to take the sk buffer and directly pass to the
application which is in the user space.

 How can i do it (my project want to read data packets from driver and give
 it to application without the help of socket mechanism.)  I saw that there
 is a system call  skb_copy_datagram_iovec() which can be used to send skb to
 userspace. Can i use it? Can anyone please help me by giving a procedure to
 implement this...

Thanks in advance,

regards,
vimal

-------------------------------------------------------


