Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUJHHO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUJHHO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJHHO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:14:57 -0400
Received: from web52906.mail.yahoo.com ([206.190.39.183]:41578 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267689AbUJHHOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 03:14:25 -0400
Message-ID: <20041008071425.96875.qmail@web52906.mail.yahoo.com>
Date: Fri, 8 Oct 2004 08:14:25 +0100 (BST)
From: Ankit Jain <ankitjain1580@yahoo.com>
Subject: are they physical address?
To: newbie <linux-newbie@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

http://www.xml.com/ldd/chapter/book/ch02.html

 00000000-0009fbff : System RAM
 0009fc00-0009ffff : reserved
 000a0000-000bffff : Video RAM area
 000c0000-000c7fff : Video ROM
 000f0000-000fffff : System ROM
 00100000-03feffff : System RAM
  00100000-0022c557 : Kernel code
  0022c558-0024455f : Kernel data
 20000000-2fffffff : Intel Corporation 440BX/ZX -
82443BX/ZX Host bridge
 68000000-68000fff : Texas Instruments PCI1225
 68001000-68001fff : Texas Instruments PCI1225 (#2)
 e0000000-e3ffffff : PCI Bus #01
 e4000000-e7ffffff : PCI Bus #01
  e4000000-e4ffffff : ATI Technologies Inc 3D Rage LT
Pro AGP-133
  e6000000-e6000fff : ATI Technologies Inc 3D Rage LT
Pro AGP-133
 fffc0000-ffffffff : reserved
what is it reserved for?

if somebody can explin me this:

"Once again, the values shown are hexadecimal ranges,
and the string after the colon is the name of the
"owner" of the I/O region. "

thanks

ankit

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
