Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314642AbSEFSfh>; Mon, 6 May 2002 14:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEFSfg>; Mon, 6 May 2002 14:35:36 -0400
Received: from jane.hollins.EDU ([192.160.94.78]:20743 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S314642AbSEFSfg>;
	Mon, 6 May 2002 14:35:36 -0400
Message-ID: <3CD6CCF5.8090903@hollins.edu>
Date: Mon, 06 May 2002 14:35:33 -0400
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020122
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.14 ntfs.o module unresolved symbols
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At make modules_install:

depmod: *** Unresolved symbols in 
/lib/modules/2.5.14-01/kernel/fs/ntfs/ntfs.o
depmod:     buffer_async
depmod:     set_buffer_async
depmod:     clear_buffer_async
make: *** [_modinst_post] Error 1


