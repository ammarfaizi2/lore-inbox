Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSHXWJX>; Sat, 24 Aug 2002 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHXWJX>; Sat, 24 Aug 2002 18:09:23 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:37636 "EHLO
	crawl.var.cx") by vger.kernel.org with ESMTP id <S316838AbSHXWJX>;
	Sat, 24 Aug 2002 18:09:23 -0400
Date: Sun, 25 Aug 2002 00:13:36 +0200
From: Frank v Waveren <fvw@var.cx>
To: linux-kernel@vger.kernel.org
Subject: auto-muting pcm when not in use
Message-ID: <1030226923OGI.fvw@yendor.var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an el-cheapo sound card in my desktop machine, which works fine
for the odd mail notification sound. However, it tends to produce
quite some white noise and a highpitched tone when not in use. I
vaguely remember some buzz (well, at least a light hum) a while back
about automatically setting the mixer to zero for synth/pcm when not
in use.. Was there ever a patch created for this, and if not, would
anyone be interested in one?

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7179 3036 E136 B85D
