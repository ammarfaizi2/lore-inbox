Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCTX1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCTX1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCTXX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:23:57 -0500
Received: from fmr24.intel.com ([143.183.121.16]:56748 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261380AbVCTXUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:20:20 -0500
Message-Id: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <christoph@graphe.net>
Subject: RE: [patch] del_timer_sync scalability patch
Date: Sun, 20 Mar 2005 15:19:33 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUto0YejS9y0yYTS5ul1UGa2UQxnA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We did exactly the same thing about 10 months back.  Nice to
see that independent people came up with exactly the same
solution that we proposed 10 months back.  In fact, this patch
is line-by-line identical to the one we post.

Hope Andrew is going to take the patch this time.

See our original posting:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108422767319822&w=2

- Ken


