Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279813AbRKAWYj>; Thu, 1 Nov 2001 17:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279815AbRKAWY3>; Thu, 1 Nov 2001 17:24:29 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:39090 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279813AbRKAWYN>; Thu, 1 Nov 2001 17:24:13 -0500
Date: Thu, 1 Nov 2001 17:24:12 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: alpha tru64 mmap broken in linus kernels
Message-ID: <20011101172412.A578@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan's 2.4.13-ac* kernels work fine, but using 2.4.13, mmap fails for tru64
binaries. i tried applying an old fix for it (similar to the one that's in
alan's tree now), but it still fails. does anyone have a patch to fix
mm/mmap.c in linus's kernels? 2.4.14-pre6 is still broken.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
