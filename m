Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTINTAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTINTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:00:19 -0400
Received: from law11-f123.law11.hotmail.com ([64.4.17.123]:27662 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261267AbTINTAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:00:12 -0400
X-Originating-IP: [220.224.1.86]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [CRYPTO] Testing Module Cleanup.
Date: Mon, 15 Sep 2003 00:30:10 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7a2_33c3_4215"
Message-ID: <Law11-F123RpXbD4dSr0004cdfc@hotmail.com>
X-OriginalArrivalTime: 14 Sep 2003 19:00:11.0292 (UTC) FILETIME=[6C39FDC0:01C37AF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7a2_33c3_4215
Content-Type: text/plain; format=flowed

Hi James.

I have cleaned up the testing module.
A complete rewrite.
Code is reduced by almost 1900+ lines in tcrypt.c.
I have compiled and test it on my machine.
The kernel size is reduced by 5 Kb.
I am including the patch for testing as an attachment.
It provides uniform interface for adding new tests.
Anyway, I think, now you won't call it a dirty module.
I expect changes in the comments at the beginning of source files.
Any suggestions are welcome.

                    -Kartikey Mahendra Bhatt

_________________________________________________________________
Talk to Karthikeyan. Watch his stunning feats. 
http://server1.msn.co.in/sp03/tataracing/index.asp Download images.

------=_NextPart_000_7a2_33c3_4215
Content-Type: application/x-bzip2; name="patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.bz2"


------=_NextPart_000_7a2_33c3_4215--
