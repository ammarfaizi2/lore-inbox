Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTGXRNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269575AbTGXRNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:13:55 -0400
Received: from math.ut.ee ([193.40.5.125]:44709 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S269512AbTGXRNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:13:54 -0400
Date: Thu, 24 Jul 2003 20:29:00 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: linux-kernel@vger.kernel.org
Subject: NFS server broken in 2.4.22-pre6?
Message-ID: <Pine.GSO.4.44.0307242023530.5806-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
(using am-utils actually) from a 3rd computer, IO error. Tried to
mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
and NFS started to work.

No more details currently but I can test more thoroughly tomorrow.

-- 
Meelis Roos             e-mail: mroos@ut.ee
                        www:    http://www.cs.ut.ee/~mroos/

