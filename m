Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTBDXUp>; Tue, 4 Feb 2003 18:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbTBDXUp>; Tue, 4 Feb 2003 18:20:45 -0500
Received: from CPE-203-51-32-65.nsw.bigpond.net.au ([203.51.32.65]:16880 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267560AbTBDXUo>; Tue, 4 Feb 2003 18:20:44 -0500
Message-ID: <3E404D06.F1CA95E8@eyal.emu.id.au>
Date: Wed, 05 Feb 2003 10:30:14 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre4-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac2
References: <200302041702.h14H2O112078@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> More IDE updates. Finally switch the IDE layer over to the ide_execute_command
> interface. This should cure problems people have seen for a long time with
> big arrays and shared IRQ. Treat this with care. The other stuff is mostly
> minor fixes and obscure updates, except for the Kahlua audio enabler
> 
> Linux 2.4.21pre4-ac2

Builds OK but note that the version says -ac1 in the top Makefile.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
