Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbRGFLX5>; Fri, 6 Jul 2001 07:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266401AbRGFLXr>; Fri, 6 Jul 2001 07:23:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33451 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266389AbRGFLXj>;
	Fri, 6 Jul 2001 07:23:39 -0400
Date: Fri, 6 Jul 2001 07:23:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: [CFT] minixfs patch
Message-ID: <Pine.GSO.4.21.0107060712500.21714-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Moves directoris into pagecache, cleans up inode table handling.
It Works Here(tm). Folks, give it a serious beating. No complaints in
a week => patch goes to Linus.

	Patch is on ftp.math.psu.edu/pub/viro/minix-c-S7-pre3. It should
apply to all recent trees.

