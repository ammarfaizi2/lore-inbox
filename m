Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313729AbSDEXlW>; Fri, 5 Apr 2002 18:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313735AbSDEXlM>; Fri, 5 Apr 2002 18:41:12 -0500
Received: from CPE-203-51-26-88.nsw.bigpond.net.au ([203.51.26.88]:4603 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S313729AbSDEXlB>; Fri, 5 Apr 2002 18:41:01 -0500
Message-ID: <3CAE3608.8DDE18EB@eyal.emu.id.au>
Date: Sat, 06 Apr 2002 09:40:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3: unresolved in radeonfb
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Linux 2.4.19pre5-ac3
> o       Small fix for the radeonfb                      (Peter Horton)

depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre5-ac3/kernel/drivers/video/radeonfb.o
depmod:         radeon_engine_init_var

I could not find this symbol in the tree.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
