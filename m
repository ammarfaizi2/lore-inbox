Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269683AbRHQExm>; Fri, 17 Aug 2001 00:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269676AbRHQExc>; Fri, 17 Aug 2001 00:53:32 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7216 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269683AbRHQExY>; Fri, 17 Aug 2001 00:53:24 -0400
Date: Fri, 17 Aug 2001 06:53:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre9aa1
Message-ID: <20010817065348.C830@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.2.20pre8aa1: 00_poll-max_fds-1
Only in 2.2.20pre9aa1: 00_poll-nfds-1

	Don't truncate nfds to max_fds, limit it instead in function of the
	rlimit fds setting.

Only in 2.2.20pre8aa1: 93_raid-2.2.18-A2_2.2.20pre2aa1-7.bz2
Only in 2.2.20pre9aa1: 93_raid-2.2.18-A2_2.2.20pre2aa1-8.bz2

	Exported some missing symbol.

Andrea
