Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHATBp>; Thu, 1 Aug 2002 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHATBp>; Thu, 1 Aug 2002 15:01:45 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29762 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316674AbSHATBo>; Thu, 1 Aug 2002 15:01:44 -0400
Date: Thu, 1 Aug 2002 21:05:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc5aa1
Message-ID: <20020801190513.GB11749@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc5aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc5aa1/

Diff between 2.4.19rc4aa1 and 2.4.19rc5aa1 (besides moving on top of
rc5):

Only in 2.4.19rc4aa1: 00_disable-reada-1

	Merged in mainline.

Only in 2.4.19rc4aa1: 00_extraversion-4
Only in 2.4.19rc5aa1: 00_extraversion-5
Only in 2.4.19rc4aa1: 9910_shm-largepage-1.gz
Only in 2.4.19rc5aa1: 9910_shm-largepage-2.gz

	Fix bug found by Randy Hron using the ltp testsuite. Fixed bug found
	by Hubert Mantel in the meminfo reporting. Fix bug found by J.A.
	Magallon in the shm read operation. I marked the 2.4.19rc4aa1 as .dontuse.
	Nevertheless if you followed the advice of backing out 9910_shm-largepage-1.gz
	you couldn't run into these three showstopper problem in the first
	place, of course the advice of backing out the whole 99??_* serie of
	patches still applies if you cannot afford any temporary instability.

Andrea
