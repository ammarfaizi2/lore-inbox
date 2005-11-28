Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVK1GH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVK1GH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 01:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVK1GH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 01:07:59 -0500
Received: from mailswap.dcl.info.waseda.ac.jp ([133.9.216.195]:22185 "EHLO
	mailswap.dcl.info.waseda.ac.jp") by vger.kernel.org with ESMTP
	id S932069AbVK1GH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 01:07:59 -0500
Date: Mon, 28 Nov 2005 15:08:11 +0900
From: Hirotaka MOTAI <motai@dcl.info.waseda.ac.jp>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Porting Nooks to 2.6
Cc: motai@dcl.info.waseda.ac.jp
Message-Id: <20051128150506.0733.MOTAI@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.23 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Sorry if this list is not appropriate for this post.

I would like to port Nooks to 2.6 kernel.

Nooks (http://nooks.cs.washington.edu/) is a lightweight kernel protection
sub system that isolates device drivers from kernels thus increasing the
reliability of the kernel.Its initial implementation is done in 2.4.18.

My questions are:

1. Does anyone already ported it to 2.6, if yes could you please give me
some guidelines?

2. If not could any one point me to any document/tips that will help me to
port it.

Thanks in advance for your concern -- Hirotaka MOTAI
