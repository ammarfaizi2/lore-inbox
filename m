Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOXEG>; Thu, 15 Feb 2001 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOXDq>; Thu, 15 Feb 2001 18:03:46 -0500
Received: from the-penguin.otak.com ([216.122.56.136]:21641 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S129066AbRBOXDn>; Thu, 15 Feb 2001 18:03:43 -0500
Date: Thu, 15 Feb 2001 15:03:02 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Samba seems to be broken in 2.4.1-ac14
Message-ID: <20010215150302.A11921@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.4.1-ac14 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samba appears to be broken in 2.4.1-ac14
No odd dmesg, modules load fine just nothing is there.
Works in 2.4.1-ac7 just fine. 
Versions follow

Samba version 2.0.7

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux the-penguin 2.4.1-ac14 #4 Thu Feb 15 09:51:30 PST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10q
modutils               2.4.1
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.1
Dynamic linker (ldd)   2.2.1
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nls_cp437 nls_iso8859-1 smbfs ipt_REJECT iptable_filter ip_tables mga ipx agpgart emu10k1 soundcore 3c59x
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


