Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310199AbSCSGO3>; Tue, 19 Mar 2002 01:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310194AbSCSGOT>; Tue, 19 Mar 2002 01:14:19 -0500
Received: from ccs.covici.com ([209.249.181.196]:14465 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S310193AbSCSGOK>;
	Tue, 19 Mar 2002 01:14:10 -0500
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.6 wrong interrupt acknowledged with alsa
From: John Covici <covici@ccs.covici.com>
Date: Tue, 19 Mar 2002 01:14:00 -0500
Message-ID: <m3sn6xf5jr.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI.  Using kernel 2.5.6 and the included alsa drivers and the beta 12
libraries and utilities I get lots of messages like the following:
Mar 18 20:23:32 ccs kernel: ALSA pcm_lib.c:184: Unexpected hw_pointer
value (stream = 1, delta: -2048, max jitter = 16384): wrong i\nterrupt
acknowledge?

This is with the via8233 sound card.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
