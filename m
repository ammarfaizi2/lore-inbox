Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTJ0OWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJ0OWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:22:50 -0500
Received: from [160.216.153.99] ([160.216.153.99]:9743 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S263170AbTJ0OWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:22:49 -0500
Date: Mon, 27 Oct 2003 15:20:57 -0500 (EST)
From: Tomas Konir <moje@vabo.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 XFS problem
Message-ID: <Pine.LNX.4.58.0310271518050.5629@moje.vabo.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
I found many messages like this in log (many means cca 50)
0x0: d8 00 06 08 00 00 00 00 49 4e 54 45 52 4e 41 4c
Filesystem "md1": XFS internal error xfs_da_do_buf(2) at line 2280 of file 
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

