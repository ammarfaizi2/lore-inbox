Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263101AbSJBOoS>; Wed, 2 Oct 2002 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSJBOoR>; Wed, 2 Oct 2002 10:44:17 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:59077 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S263101AbSJBOoR>; Wed, 2 Oct 2002 10:44:17 -0400
Date: Wed, 2 Oct 2002 10:49:41 -0400 (EDT)
From: Bill Davidsen <bill@tmr.com>
Reply-To: <davidsen@tmr.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.40 - aha142x won't build as module
Message-ID: <Pine.LNX.4.33.0210021043570.1333-100000@iccarus.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also "make menuconfig" has errors and won't change the module to built-in.
And got missing symbols in ipt_owner with no aha152x support in the
kernel.

Also tried -mm1, same problems.

I barely have time to test kernels this fall when they will compile, so
don't expect any quick fixes from me, I just got 2.5.38-mm2 to boot.
-- 
bill on a temporary machine... <davidsen@tmr.com>

