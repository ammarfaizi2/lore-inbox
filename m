Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTA1WlO>; Tue, 28 Jan 2003 17:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTA1WlO>; Tue, 28 Jan 2003 17:41:14 -0500
Received: from APlessis-Bouchard-101-1-5-111.abo.wanadoo.fr ([80.14.165.111]:20488
	"EHLO smtp") by vger.kernel.org with ESMTP id <S261593AbTA1WlO>;
	Tue, 28 Jan 2003 17:41:14 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre3aa1 kernel: allocation failed
From: laurent.ml@linuxfr.org
Date: Tue, 28 Jan 2003 22:50:31 +0000
Message-ID: <wazza.874r7sq47c.fsf@message.id>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying 2.4.21pre3aa1 kernel, it was running very well for 1 day,
but I'm now experiencing 'kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)' kind of errors.
It's a HIGHMEM kernel (compiled with gcc 3.2.2) with 1Go of RAM.
(i686 athlon xp arch)
I was using xmms with alsa-0.9.0rc6 when messages started. Since I haven't
been able to use alsa pcm devices nor oss ones. 
I'm available to give you more information and do some tests.

Regards

-- 
Laurent
