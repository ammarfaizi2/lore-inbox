Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRIDOpQ>; Tue, 4 Sep 2001 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRIDOpJ>; Tue, 4 Sep 2001 10:45:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:18327 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S269174AbRIDOox>;
	Tue, 4 Sep 2001 10:44:53 -0400
Date: Tue, 4 Sep 2001 16:45:09 +0200
From: Sebastian Heidl <heidl@zib.de>
To: linux-kernel@vger.kernel.org
Subject: DMA to/from user buffers
Message-ID: <20010904164509.A27144@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-www.distributed.net: 28 OGR packets (4.82 Tnodes) [3.98 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

two questions about using an user-supplied buffer (e.g. malloced
in user space) for DMA transfers:

1. Is it possible ?
2. What restrictions/requirements apply for the buffer (alignment...) ?

Documentation/DMA-mapping.txt only talks about buffers allocated in
kernel space.

thanks,
_sh_

-- 
