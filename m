Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287440AbSASVtr>; Sat, 19 Jan 2002 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287461AbSASVti>; Sat, 19 Jan 2002 16:49:38 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:17626 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S287440AbSASVt3>; Sat, 19 Jan 2002 16:49:29 -0500
Subject: ext2 module in 2.4.18-pre4 broken?
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 19 Jan 2002 16:49:23 -0500
Message-Id: <1011476968.1362.53.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Making ext2 as a module in 2.4.18-pre4 seems to be broken.



depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre4/kernel/fs/ext2/ext2.o
depmod:         waitfor_one_page



is this true or just something patching seems to have messed up over the
versions?

