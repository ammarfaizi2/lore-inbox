Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSAOBIc>; Mon, 14 Jan 2002 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289345AbSAOBIX>; Mon, 14 Jan 2002 20:08:23 -0500
Received: from amdext.amd.com ([139.95.251.1]:32399 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S289338AbSAOBIK>;
	Mon, 14 Jan 2002 20:08:10 -0500
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <3C4380F2.292475B9@cmdmail.amd.com>
Date: Mon, 14 Jan 2002 17:08:02 -0800
From: "Amit Gupta" <amit.gupta@amd.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: arpd not working in 2.4.17 or 2.5.1
X-WSS-ID: 105D5F79185166-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I am running 2.5.1 kernel on a 2 AMD processor system and have enable
routing messages, netlink and arpd support inside kernel as described in
arpd docs.

Then after making 36 character devices, when I run arpd, it's starts up
but always keeps silent (strace) and the kernel also does not keep it's
256 arp address limit.

Pls help fix it, I need linux to be able to talk to more than 1024
clients.

Thanks in Advance.

Amit
amit.gupta@amd.com



