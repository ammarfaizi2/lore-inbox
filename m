Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSGENzm>; Fri, 5 Jul 2002 09:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317451AbSGENzl>; Fri, 5 Jul 2002 09:55:41 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:7605 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S317450AbSGENzl>; Fri, 5 Jul 2002 09:55:41 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793972@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Question concerning ifconfig
Date: Fri, 5 Jul 2002 09:58:14 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a Red Hat 7.2 load (Kernel version 2.4.7-10). I am trying to
enter the following command to change the MAC address on my device.

ifconfig ifp0 hw ether A2:A5:A5:01:00:00

ifp0 is my own device which replaces eth0. The system gives me a response
"SIOCSIFHWADDR : device or resources busy"
The same exact command works on my 2.2.16 Kernel. Any ideas why the error.
Please CC me directly in any responses.

Thanks in advance,  

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

