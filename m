Return-Path: <linux-kernel-owner+w=401wt.eu-S1751219AbWLOHqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWLOHqv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 02:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOHqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 02:46:51 -0500
Received: from mail.gdatech.co.in ([202.144.30.226]:42386 "EHLO gdatech.co.in"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751219AbWLOHqu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 02:46:50 -0500
X-Greylist: delayed 1109 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 02:46:50 EST
X-Propel-Return-Path: <n.balaji@gdatech.co.in>
Message-ID: <35900.202.144.30.226.1166167961.squirrel@mail.gdatech.co.in>
Date: Fri, 15 Dec 2006 13:02:41 +0530 (IST)
Subject: Asynchronous Crypto suppor for MPC8360E's Security Engine
From: n.balaji@gdatech.co.in
To: "David McCullough" <david_mccullough@au.securecomputing.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
       n.balaji@gdatech.co.in
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Priority: 3
Importance: Normal
Content-Transfer-Encoding: 7BIT
X-Propel-ID: r6ce232809-00-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
  I am working on MPC8360E Security Engine. I have ported the Openswan
2.4.5(IPSec --KLIPS) with OCF to MPC8360E's Security Engine (Talitos).
Encryption and Decryption is working. But when I check the performance of
Talitos with netio benchmark Tool, IPSec S/W Algorithms is giving more
bandwidth than Talitos.
  I do not know that why Talitos is giving less bandwidth and any probelm
in Openswan or OCF or Talitos driver or Talitos H/W. Please give your
suggestions and if you have any link related to Talitos, send to me.

  Linux kernel version is 2.6.11.

 I am not a member of the above mailing lists. Please send the mail to me.

-Thanks
 N.Balaji


