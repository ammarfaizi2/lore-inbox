Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTJ0Uzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTJ0Uzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:55:50 -0500
Received: from c2mailgwalt.mailcentro.com ([207.183.238.112]:10920 "EHLO
	c2mailgwalt.mailcentro.com") by vger.kernel.org with ESMTP
	id S263583AbTJ0Uzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:55:36 -0500
X-Version: Mailcentro(english)
X-SenderIP: 212.59.194.15
X-SenderID: 7831070
From: "Jose Luis Alarcon Sanchez" <jlalarcon@chevy.zzn.com>
Message-Id: <5D1E48CBD12622549A15E07174297140@jlalarcon.chevy.zzn.com>
Date: Mon, 27 Oct 2003 21:55:34 +0100
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 XFS problem
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Begin Original Message ----

Hi
I found many messages like this in log (many means cca 50)
0x0: d8 00 06 08 00 00 00 00 49 4e 54 45 52 4e 41 4c
Filesystem "md1": XFS internal error xfs_da_do_buf(2) at line 2280 of
file 
fs/xfs/xfs_da_btree.c.  Caller 0xc01b87a7
Call Trace: [<c01b8189>]  [<c01b87a7>]  [<c01b87a7>]  [<c01f7069>]  
[<c01b64e0>]  [<c01b87a7>]  [<c01c15e7>]  [<c01c15e7>]  [<c0109be5>]  
[<c01b6654>]  [<c01c30ff>]  [<c01bac3a>]  [<c0118ad8>]  [<c01eb57c>]  
[<c01f0fd0>]  [<c01d61f0>]  [<c01ff2c7>]  [<c015ea68>]  [<c015ed06>]  
[<c015f1b0>]  [<c0137387>]  [<c0161c97>]  [<c01ff770>]  [<c015f26d>]  
[<c015ffd3>]  [<c01505ee>]  [<c0150aab>]  [<c01091db>]

xfs_repair found no errors.
mail me if you want more info.

	MOJE

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

---- End Original Message ----


  Hi.

  I'm using XFS with 2.6.0-test9 too. In my log files don´t be any
kind of error. All working quickly and okey. Kernel compiled with
gcc 3.3.1.

  Regards.

  Jose.


http://linuxespana.scripterz.org

FreeBSD RELEASE 4.8.
Mandrake Linux 9.2 Kernel 2.6.0-test9 XFS.
Registered BSD User 51101.
Registered Linux User #213309.
Memories..... You are talking about memories. 
Rick Deckard. Blade Runner.


