Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbSJOPUl>; Tue, 15 Oct 2002 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSJOPUl>; Tue, 15 Oct 2002 11:20:41 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:43908 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S263711AbSJOPUZ>; Tue, 15 Oct 2002 11:20:25 -0400
Date: Tue, 15 Oct 2002 17:25:58 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: andrea@suse.de
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 2.4.20-pre10-aa1: unresolved symbol in xfs.o
Message-ID: <20021015172558.A3154@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

I'm trying to compile 2.4.20-pre10aa1 with xfs enabled as module.
make modules_install ends up in:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.20-pre10aa1/kernel/fs/xfs/xfs.o
depmod: 	do_generic_file_write

what to do?

Christian
