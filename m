Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270154AbRHMMZF>; Mon, 13 Aug 2001 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRHMMYz>; Mon, 13 Aug 2001 08:24:55 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:51974 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270154AbRHMMYk>; Mon, 13 Aug 2001 08:24:40 -0400
Date: Mon, 13 Aug 2001 14:24:28 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux-kernel@vger.kernel.org
Subject: nfs bug in 2.4.9-pre2
Message-ID: <20010813142428.A467@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting a file system with (rw,no_root_squash) to an hpux-system (nfs-v3)
works with 2.4.8-pre8 but not with 2.4.9-pre2.

As root or user on the hpux-system you see (with bdf) that
the filesystem is mounted but no contents are listed.

I am not on this list.
-- 
Best regards
Klaus Dittrich

e-mail: kladit@t-online.de
