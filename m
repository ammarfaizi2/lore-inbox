Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbTCTTrK>; Thu, 20 Mar 2003 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbTCTTrK>; Thu, 20 Mar 2003 14:47:10 -0500
Received: from gta.loris.tv ([217.89.68.44]:820 "EHLO gta.loris.tv")
	by vger.kernel.org with ESMTP id <S262205AbTCTTrJ>;
	Thu, 20 Mar 2003 14:47:09 -0500
Date: Thu, 20 Mar 2003 20:56:57 +0100
From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
To: linux-kernel@vger.kernel.org
Subject: Release of 2.4.21
Message-ID: <20030320195657.GA3270@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

how about releasing 2.4.21 with the ptrace()-fix applied immediately
like it has been done with 2.2.25?

I think it's a serious bug and therefore it's time for a security-update.

If you think of ISC bind, PHP, sendmail or other software a new release
follows right after the availability of the patch. I'd like Linux
(and glibc as well) to do the same. You cannot call 2.4.20 a stable kernel
with such a bug, so as a leader of the 2.4.x-series you cannot call the
whole branch "stable".

World needs to update, best way to enforce is by a new release.

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP: v2-key via keyserver

Das letzte Schoene, das in C geschrieben wurde, war Schuberts 9. Sinfonie.
