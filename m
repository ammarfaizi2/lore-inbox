Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbRFTVdu>; Wed, 20 Jun 2001 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbRFTVdo>; Wed, 20 Jun 2001 17:33:44 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:57097 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264632AbRFTVd3>; Wed, 20 Jun 2001 17:33:29 -0400
Message-ID: <3B3116A3.E89360DE@netpathway.com>
Date: Wed, 20 Jun 2001 16:33:23 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac16 kernel panic
In-Reply-To: <20010619183135.A24337@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5-ac16 patch applied to clean 2.4.5 tree. 2.4.5-ac15 boots
with no problem.

model name      : AMD Athlon(tm) Processor

Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).


PnP: PNP BIOS installation structure at 0xc00fc2b0
PnP: PNP BIOS version 1.0, entry at f0000:c2e0, dseg at f0000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01112cf>]
EFLAGS: 00010286
eax: 007ec000   ebx: e0800000   ecx: 3f7ec000   edx: c0101000
esi: 1ffec000   edi: 1ffec000   ebp: 00000000   esp: dffe3f54
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dffe3000)
Stack: e0800000 1ffec000 1ffec000 00000000 00000246 1ffec000 1ffec000 1ffec000
       c0126384 00000010 007ec000 c0101e08 1ffec000 3f7ec000 c0111521 e0800000
       1ffec000 1ffec000 00000000 1ffec000 c00f6ed8 00000014 000f6ed0 3ffd7fff
Call Trace: [<e0800000>] [<c0126384>] [<c0101e08>] [<c0111521>] [<e0800000>]
   [<c0105267>] [<c01056e8>]

Code: 0f 0b e9 40 01 00 00 8b 44 24 28 8b 54 24 2c 8b 4c 24 34 8b
 <0>Kernel panic: Attempted to kill init
--
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


