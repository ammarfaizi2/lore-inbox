Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTBPBWy>; Sat, 15 Feb 2003 20:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBPBWx>; Sat, 15 Feb 2003 20:22:53 -0500
Received: from dp.samba.org ([66.70.73.150]:10716 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265126AbTBPBWx>;
	Sat, 15 Feb 2003 20:22:53 -0500
Date: Sun, 16 Feb 2003 12:31:48 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.61 oops running SDET
Message-ID: <20030216013148.GE9833@krispykreme>
References: <33450000.1045357862@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33450000.1045357862@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> SDET on 16-way NUMA-Q.

SDET on 4way ppc64 is seeing what appears to be the same problem.

I couldnt get a backtrace out of it last time but the PC was in
render_sigset_t.

Anton
