Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263110AbREWOrF>; Wed, 23 May 2001 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbREWOqz>; Wed, 23 May 2001 10:46:55 -0400
Received: from ns2.radioschefer.ch ([62.2.224.35]:32013 "EHLO
	ns2.radioschefer.ch") by vger.kernel.org with ESMTP
	id <S263110AbREWOqo>; Wed, 23 May 2001 10:46:44 -0400
Message-ID: <3B0BCA91.32B334B8@bluewin.ch>
Date: Wed, 23 May 2001 16:34:57 +0200
From: Stephan Brauss <sbrauss@bluewin.ch>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD DT  (Win95; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 kernel freeze
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an ASUS A7V133 (VIA VT8363A) with 5 PCI slots
and I installed kernel 2.4.4.
All runs fine when I only use PCI slots 1 to 3.
When I use slots 4 or 5, the system
freezes when data is passed to a device in one of
these slots. I tested with a Promise Ultra100, an Intel
Etherexpress Pro 100, and a DEC EtherWorks.
The problem does not turn up in 2.4.0 and 2.2.18 (standard
kernels from SuSE 7.1). I reproduced the error in a second
simillar system with the same motherboard.

Maybe this information is usefull...
If someone wants to know more details, please email me
directly as I'm currently not subscribed to this list.

Stephan
