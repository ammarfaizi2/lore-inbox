Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUGPDmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUGPDmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 23:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUGPDmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 23:42:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:28094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266333AbUGPDmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:42:53 -0400
Date: Thu, 15 Jul 2004 20:42:51 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: <ltp-list@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: LTP Results - July 15, 2004
Message-ID: <Pine.LNX.4.33.0407152041550.5901-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0407152041552.5901@osdlab.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, this time _with_ a subject line)

LTP version LTP-20040506:

Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
----------------------------------------------------------------------
2.6.7-mm7              294831  2-way  7184    45     3     6    44.0
2.6.7-rc3-mm2          293949  2-way  7223     8     3     6    46.5
osdl-2.6.7             294992  2-way  7223     5     3     3   124.9
patch-2.6.8-rc1        294973  2-way  7184    45     3     6    47.3



LTP version LTP-20040707:

Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
----------------------------------------------------------------------
patch-2.6.8-rc1-bk1    295008  2-way  7191    43     3     6    50.6
patch-2.6.8-rc1-bk2    295025  2-way  7191    41     3     3   125.1
patch-2.6.8-rc1-bk3    295100  2-way  7191    43     3     6    53.8
patch-2.6.8-rc1-bk4    295128  2-way  7191    43     3     6    53.5
2.6.8-rc1-mm1          295081  2-way  7192    41     3     6    48.6


More results + details:  http://developer.osdl.org/bryce/ltp/


