Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSKMUVv>; Wed, 13 Nov 2002 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKMUVv>; Wed, 13 Nov 2002 15:21:51 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1028 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262670AbSKMUVt>;
	Wed, 13 Nov 2002 15:21:49 -0500
Date: Tue, 12 Nov 2002 22:37:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: loop no longer works in 2.5.47?
Message-ID: <20021112213726.GA1151@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried to loop-mount ext2 filesystem, and it seems to no longer work:

Buffer I/O error on device loop(7,0), logical block 0

								Pavel
-- 
When do you have heart between your knees?
