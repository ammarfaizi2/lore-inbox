Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265585AbSKFE6M>; Tue, 5 Nov 2002 23:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265586AbSKFE6L>; Tue, 5 Nov 2002 23:58:11 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:43509 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265585AbSKFE6L>; Tue, 5 Nov 2002 23:58:11 -0500
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758D12@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'David C. Hansen'" <haveblue@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: Panic on startup with e1000, PPC64
Date: Tue, 5 Nov 2002 21:03:30 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just put a pair of e1000's in my 4-way PPC64 box and booted 
> a known-good kernel.  It oopsed on boot.  I'm going to try 2.5 next.

It's not liking the reset being issued via I/O-mapped.

Can we get access to your PPC64 box?  We need to troubleshoot Anton's issue
with e1000/TSO on PPC64, and our PowerMac is acting up.  Thanks.

-scott
