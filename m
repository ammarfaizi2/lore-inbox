Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSKVS0e>; Fri, 22 Nov 2002 13:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSKVS0e>; Fri, 22 Nov 2002 13:26:34 -0500
Received: from imail.ricis.com ([64.244.234.16]:28433 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S265190AbSKVS0d>;
	Fri, 22 Nov 2002 13:26:33 -0500
Date: Fri, 22 Nov 2002 12:33:41 -0600
From: Lee Leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: snd-emu10k1.o
Message-Id: <20021122123341.577b1894.lee@ricis.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.

i am running the 2.4.18-64GB-SMP kernel.  with this kernel, i have in my /lib/modules/2.4.18-64GB-SMP/ directory, the snd-emu10k1.o module.

i rebuilt my kernel to be 2.4.18-4GB-SMP.  in my new /lib/modules/2.4.18-4GB-SMP/ directory, i no longer have the snd-emu10k1.o module.

i searched with the command 'find /usr/src/ -name "snd-*"' , but there were no files found.

i am running the suse 8.0 professional distribution.

does anyone have any ideas of whats going on here?  am I missing some files? 
please help me

-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
