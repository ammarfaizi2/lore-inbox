Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTEZTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTEZTS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:18:26 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:51678 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S262148AbTEZTSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:18:25 -0400
Date: Mon, 26 May 2003 21:31:36 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: xfs don't compil in linux-2.5 BK
Message-ID: <20030526193136.GB10276@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know if I have fetched the source with BK the right way...
Anyway the compil ends that way:

  CC      fs/xfs/xfs_rw.o
  CC      fs/xfs/pagebuf/page_buf.o
In file included from fs/xfs/pagebuf/page_buf.c:65:
fs/xfs/pagebuf/page_buf_internal.h:46:24: operator '<' has no left
operand
make[2]: *** [fs/xfs/pagebuf/page_buf.o] Error 1
make[1]: *** [fs/xfs] Error 2
make: *** [fs] Error 2
141.112u 14.914s 3:19.78 78.0%  0+0k 0+0io 492771pf+0w
Exit 2


	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
