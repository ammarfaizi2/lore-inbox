Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbRFQXq5>; Sun, 17 Jun 2001 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbRFQXqq>; Sun, 17 Jun 2001 19:46:46 -0400
Received: from line153.ba.psg.sk ([195.80.179.153]:52354 "HELO ivan.doma")
	by vger.kernel.org with SMTP id <S263160AbRFQXqg>;
	Sun, 17 Jun 2001 19:46:36 -0400
Date: Mon, 18 Jun 2001 01:45:47 +0200
From: Ivan Vadovic <pivo@pobox.sk>
To: linux-kernel@vger.kernel.org
Subject: any good diff merging utility?
Message-ID: <20010618014547.B1063@ivan.doma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I like to build kernels with a bunch of patches on top to test new stuff. The
problem is that it takes a lot of effort to fix all the failed hunks during
patching that really wouldn't have to be failed if only patch was a little more
inteligent and could merge several patches into one ( if possible) or if could
take into account already applied patches.

Well, are there any utilities to merge diffs? I couldn't find any on freshmeat.
So what are you using to stack many patches onto the kernel tree? Just manualy
modify the diff? I'll try to write something more automatic if nothing comes up.

Ivan Vadovic
