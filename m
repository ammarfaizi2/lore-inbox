Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUH0WpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUH0WpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUH0WnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:43:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:37837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266233AbUH0Wll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:41:41 -0400
Date: Fri, 27 Aug 2004 15:41:41 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <ltp-list@lists.sourceforge.net>
Subject: Re: LTP Results 2004-08-11
In-Reply-To: <Pine.LNX.4.33.0408111621540.17292-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0408271537010.4848-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an update on the LTP test runs for the kernel.  Everything has
been looking pretty calm.

Bryce

Patch Name           TestReq#    LTP Ver    CPU    PASS  FAIL  WARN  BROK RunTime
---------------------------------------------------------------------------------
linux-2.4.27           295880   20040707  2-way    7234     3     3     6    68.9
patch-2.4.27-rc3       294624   20040506  2-way    7226     6     3     6    69.0
2.6.7-mm3              295809   20040707  2-way    7192    41     3     6    53.5
2.6.7-mm6              294691   20040506  2-way    7178    46     3     6    45.2
2.6.7-mm7              294831   20040506  2-way    7184    45     3     6    44.0
patch-2.6.8-rc1        294973   20040506  2-way    7184    45     3     6    47.3
patch-2.6.8-rc2        295222   20040707  2-way    7229     5     3     6    52.6
patch-2.6.8-rc3        295778   20040707  2-way    7229     5     3     6    47.4
2.6.8-rc1-mm1          295081   20040707  2-way    7192    41     3     6    48.6
2.6.8-rc2-mm1          295474   20040707  2-way    7229     5     3     6    49.5
2.6.8-rc4-mm1          296043   20040707  2-way    7224     7     3     6    49.4
linux-2.6.8            296252   20040707  2-way    7229     3     3     3   125.1
linux-2.6.8.1          296304   20040707  2-way    7229     5     3     6    50.2
patch-2.6.9-rc1-bk1    296883   20040707  2-way    7224     7     3     6    52.6
---------------------------------------------------------------------------------

* Note:  When RunTime > 120 min, this usually indicates a test hung.

* For details on any particular test, please access it via

    http://khack.osdl.org/stp/$TestReq

* More info and search tools available at http://www.osdl.org/stp/

Bryce


